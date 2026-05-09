import 'package:flutter/material.dart';
import 'package:lumiere/features/orders/data/models/order.dart';

class OrderStatusStepper extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderStatusStepper({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StepData('Pending', Icons.schedule_rounded, OrderStatus.pending),
      _StepData(
        'Accepted',
        Icons.check_circle_outline_rounded,
        OrderStatus.accepted,
      ),
      _StepData('Completed', Icons.verified_rounded, OrderStatus.completed),
    ];

    if (currentStatus == OrderStatus.cancelled) {
      return _buildCancelledState();
    }

    int currentIdx = steps.indexWhere((s) => s.status == currentStatus);
    if (currentIdx == -1) currentIdx = 0;

    return Container(
      padding: const EdgeInsets.all(20),
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
          const Text(
            'Order Progress',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff2D3436),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isOdd) {
                int stepIdx = index ~/ 2;
                bool isCompleted = stepIdx < currentIdx;
                return Expanded(
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: isCompleted
                          ? const Color(0xff10B981)
                          : Colors.grey.shade200,
                    ),
                  ),
                );
              } else {
                int stepIdx = index ~/ 2;
                bool isCompleted = stepIdx < currentIdx;
                bool isCurrent = stepIdx == currentIdx;
                return _buildStep(steps[stepIdx], isCompleted, isCurrent);
              }
            }),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.map((s) {
              int stepIdx = steps.indexOf(s);
              bool isActive = stepIdx <= currentIdx;
              return Text(
                s.label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive
                      ? const Color(0xff2D3436)
                      : Colors.grey.shade400,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(_StepData step, bool isCompleted, bool isCurrent) {
    Color bgColor;
    Color iconColor;

    if (isCompleted) {
      bgColor = const Color(0xff10B981);
      iconColor = Colors.white;
    } else if (isCurrent) {
      bgColor = const Color(0xff3B82F6);
      iconColor = Colors.white;
    } else {
      bgColor = Colors.grey.shade200;
      iconColor = Colors.grey.shade400;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: bgColor.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Icon(
        isCompleted ? Icons.check_rounded : step.icon,
        color: iconColor,
        size: 20,
      ),
    );
  }

  Widget _buildCancelledState() {
    return Container(
      padding: const EdgeInsets.all(20),
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
              color: const Color(0xffEF4444).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cancel_rounded,
              color: Color(0xffEF4444),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Cancelled',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffEF4444),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'This order has been cancelled',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepData {
  final String label;
  final IconData icon;
  final OrderStatus status;

  _StepData(this.label, this.icon, this.status);
}
