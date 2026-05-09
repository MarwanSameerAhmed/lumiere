import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/admin/presentaion/view/pages/OrdersManagement/adminOrderDetail.dart';
import 'package:lumiere/features/admin/presentaion/view/widgets/adminManagementHeader.dart';
import 'package:lumiere/features/orders/data/models/order.dart';
import 'package:lumiere/features/orders/presentation/manager/orderProvider.dart';
import 'package:lumiere/features/orders/presentation/view/widgets/orderCard.dart';
import 'package:lumiere/features/orders/presentation/view/widgets/orderStatsCard.dart';
import 'package:provider/provider.dart';

class AdminOrdersManagement extends StatefulWidget {
  const AdminOrdersManagement({super.key});

  @override
  State<AdminOrdersManagement> createState() => _AdminOrdersManagementState();
}

class _AdminOrdersManagementState extends State<AdminOrdersManagement> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).fetchAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              child: Adminmanagementheader(
                Title: 'Orders',
                showBackButton: false,
              ),
            ),

            Expanded(
              child: Consumer<OrderProvider>(
                builder: (context, orderProvider, child) {
                  if (orderProvider.isLoading &&
                      orderProvider.allOrders.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (orderProvider.errorMessage != null &&
                      orderProvider.allOrders.isEmpty) {
                    return _buildErrorState(orderProvider);
                  }

                  return RefreshIndicator(
                    onRefresh: () => orderProvider.fetchAllOrders(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatsSection(orderProvider),
                          const SizedBox(height: 20),

                          _buildFilterChips(orderProvider),
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'All Orders',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                '${orderProvider.filteredOrders.length} orders',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          if (orderProvider.filteredOrders.isEmpty)
                            _buildEmptyState()
                          else
                            ...orderProvider.filteredOrders.map(
                              (order) => OrderCard(
                                order: order,
                                showUserName: true,
                                onTap: () => _navigateToDetail(order),
                              ),
                            ),

                          const SizedBox(height: 20),
                        ],
                      ),
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

  Widget _buildStatsSection(OrderProvider provider) {
    return Row(
      children: [
        OrderStatsCard(
          title: 'Pending',
          count: '${provider.pendingCount}',
          icon: Icons.schedule_rounded,
          color: const Color(0xffF59E0B),
        ),
        const SizedBox(width: 10),
        OrderStatsCard(
          title: 'Accepted',
          count: '${provider.acceptedCount}',
          icon: Icons.check_circle_outline_rounded,
          color: const Color(0xff3B82F6),
        ),
        const SizedBox(width: 10),
        OrderStatsCard(
          title: 'Completed',
          count: '${provider.completedCount}',
          icon: Icons.verified_rounded,
          color: const Color(0xff10B981),
        ),
      ],
    );
  }

  Widget _buildFilterChips(OrderProvider provider) {
    final filters = [
      {'label': 'All', 'value': 'all'},
      {'label': 'Pending', 'value': 'pending'},
      {'label': 'Accepted', 'value': 'accepted'},
      {'label': 'Completed', 'value': 'completed'},
      {'label': 'Cancelled', 'value': 'cancelled'},
    ];

    String currentFilter = provider.selectedStatusFilter ?? 'all';

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          bool isSelected = currentFilter == filter['value'];
          return GestureDetector(
            onTap: () => provider.setFilter(filter['value']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.KMainBackgroundButtonColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.KMainBackgroundButtonColor
                      : Colors.grey.shade200,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors
                              .KMainBackgroundButtonColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                filter['label']!,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_rounded,
              size: 70,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'No orders found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Orders will appear here once customers place them',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
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
            onPressed: () => provider.fetchAllOrders(),
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
      MaterialPageRoute(builder: (_) => AdminOrderDetail(order: order)),
    );
  }
}
