import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/orders/data/models/order.dart';
import 'package:lumiere/features/orders/presentation/manager/orderProvider.dart';
import 'package:lumiere/features/orders/presentation/view/pages/customerOrderDetail.dart';
import 'package:lumiere/features/orders/presentation/view/widgets/orderCard.dart';
import 'package:provider/provider.dart';

class CustomerOrdersDashboard extends StatefulWidget {
  const CustomerOrdersDashboard({super.key});

  @override
  State<CustomerOrdersDashboard> createState() =>
      _CustomerOrdersDashboardState();
}

class _CustomerOrdersDashboardState extends State<CustomerOrdersDashboard> {
  int _selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOrders();
    });
  }

  void _loadOrders() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Provider.of<OrderProvider>(
        context,
        listen: false,
      ).fetchUserOrders(userId);
    }
  }

  List<OrderModel> _getFilteredOrders(List<OrderModel> orders) {
    switch (_selectedFilter) {
      case 1: // Active
        return orders
            .where(
              (o) =>
                  o.status == OrderStatus.pending ||
                  o.status == OrderStatus.accepted,
            )
            .toList();
      case 2: // Completed
        return orders
            .where(
              (o) =>
                  o.status == OrderStatus.completed ||
                  o.status == OrderStatus.cancelled,
            )
            .toList();
      default:
        return orders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Orders',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2D3436),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Consumer<OrderProvider>(
                        builder: (_, provider, __) => Text(
                          '${provider.userOrders.length} total orders',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Consumer<OrderProvider>(
                    builder: (_, provider, __) {
                      final activeCount = provider.userOrders
                          .where(
                            (o) =>
                                o.status == OrderStatus.pending ||
                                o.status == OrderStatus.accepted,
                          )
                          .length;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: activeCount > 0
                              ? const Color(0xff3B82F6).withOpacity(0.1)
                              : const Color(0xffF0EDE4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              size: 16,
                              color: activeCount > 0
                                  ? const Color(0xff3B82F6)
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$activeCount active',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: activeCount > 0
                                    ? const Color(0xff3B82F6)
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildFilterTabs(),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: Consumer<OrderProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading && provider.userOrders.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage != null &&
                      provider.userOrders.isEmpty) {
                    return _buildErrorState(provider);
                  }

                  final filtered = _getFilteredOrders(provider.userOrders);

                  if (filtered.isEmpty) {
                    return _buildEmptyState();
                  }

                  return RefreshIndicator(
                    onRefresh: () async => _loadOrders(),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final order = filtered[index];
                        return OrderCard(
                          order: order,
                          showUserName: false,
                          onTap: () => _navigateToDetail(order),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ['All', 'Active', 'Completed'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xffF0EDE4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          bool isSelected = _selectedFilter == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontSize: 13,
                      color: isSelected
                          ? const Color(0xff2D3436)
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xffF0EDE4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 50,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No orders yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your orders will appear here once you start shopping',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(OrderProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Failed to load orders',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _loadOrders,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.KMainBackgroundButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(OrderModel order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CustomerOrderDetail(order: order)),
    );
  }
}
