import 'package:flutter/material.dart';
import 'package:lumiere/core/constants/colors.dart';
import 'package:lumiere/features/orders/data/models/order.dart';
import 'package:lumiere/features/orders/presentation/manager/orderProvider.dart';
import 'package:lumiere/features/orders/presentation/view/widgets/orderItemCard.dart';
import 'package:lumiere/features/orders/presentation/view/widgets/orderStatusBadge.dart';
import 'package:lumiere/features/orders/presentation/view/widgets/orderStatusStepper.dart';
import 'package:provider/provider.dart';

class AdminOrderDetail extends StatefulWidget {
  final OrderModel order;

  const AdminOrderDetail({super.key, required this.order});

  @override
  State<AdminOrderDetail> createState() => _AdminOrderDetailState();
}

class _AdminOrderDetailState extends State<AdminOrderDetail> {
  late OrderStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.KSecoundaryBackgroundColor,
      body: SafeArea(
        child: Column(
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
                        'Order Details',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '#${widget.order.orderId.substring(0, 8).toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // زر الحذف
                      GestureDetector(
                        onTap: () => _showDeleteDialog(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red.shade400,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // زر الرجوع
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xffF0EDE4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black87,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderStatusStepper(currentStatus: _currentStatus),
                    const SizedBox(height: 20),

                    _buildCustomerInfo(),
                    const SizedBox(height: 20),

                    _buildStatusChanger(),
                    const SizedBox(height: 20),

                    Text(
                      'ORDER ITEMS',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...widget.order.items.map((item) {
                      if (item is Map<String, dynamic>) {
                        return OrderItemCard(item: item);
                      }
                      return const SizedBox.shrink();
                    }),
                    const SizedBox(height: 20),

                    _buildOrderSummary(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff243352).withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: Color(0xff243352),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.order.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xff2D3436),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Customer',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          OrderStatusBadge(status: _currentStatus),
        ],
      ),
    );
  }

  Widget _buildStatusChanger() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UPDATE STATUS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: OrderStatus.values.map((status) {
              bool isSelected = _currentStatus == status;
              Color statusColor = _getStatusColor(status);
              return Expanded(
                child: GestureDetector(
                  onTap: () => _updateStatus(status),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? statusColor.withOpacity(0.15)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? statusColor.withOpacity(0.5)
                            : Colors.grey.shade200,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _getStatusIcon(status),
                          color: isSelected
                              ? statusColor
                              : Colors.grey.shade400,
                          size: 18,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getStatusLabel(status),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? statusColor
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER SUMMARY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 14),
          _summaryRow('Items', '${widget.order.items.length}'),
          const SizedBox(height: 8),
          _summaryRow(
            'Date',
            '${widget.order.createdAt.day}/${widget.order.createdAt.month}/${widget.order.createdAt.year}',
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: Colors.grey.shade100),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff2D3436),
                ),
              ),
              Text(
                '${widget.order.totalPrice.toStringAsFixed(2)} SAR',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff243352),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xff2D3436),
          ),
        ),
      ],
    );
  }

  void _updateStatus(OrderStatus newStatus) async {
    final provider = Provider.of<OrderProvider>(context, listen: false);
    final success = await provider.updateOrderStatus(
      widget.order.orderId,
      newStatus,
    );
    if (success && mounted) {
      setState(() {
        _currentStatus = newStatus;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Status updated to ${_getStatusLabel(newStatus)}'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _getStatusColor(newStatus),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  void _showDeleteDialog(BuildContext context) {
    bool isDeleting = false;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColors.KSecoundaryBackgroundColor,
            title: const Text(
              'Delete Order',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'This action cannot be undone. Are you sure you want to delete this order?',
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                onPressed: isDeleting ? null : () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: isDeleting
                    ? null
                    : () async {
                        setState(() => isDeleting = true);
                        try {
                          final provider = Provider.of<OrderProvider>(
                            context,
                            listen: false,
                          );
                          final success = await provider.deleteOrder(
                            widget.order.orderId,
                          );
                          if (context.mounted) {
                            Navigator.pop(context); // Close dialog
                            if (success) {
                              Navigator.pop(context); // Go back
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Order deleted successfully'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          setState(() => isDeleting = false);
                        }
                      },
                child: isDeleting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return const Color(0xffF59E0B);
      case OrderStatus.accepted:
        return const Color(0xff3B82F6);
      case OrderStatus.completed:
        return const Color(0xff10B981);
      case OrderStatus.cancelled:
        return const Color(0xffEF4444);
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.schedule_rounded;
      case OrderStatus.accepted:
        return Icons.check_circle_outline_rounded;
      case OrderStatus.completed:
        return Icons.verified_rounded;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  String _getStatusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.accepted:
        return 'Accepted';
      case OrderStatus.completed:
        return 'Done';
      case OrderStatus.cancelled:
        return 'Cancel';
    }
  }
}
