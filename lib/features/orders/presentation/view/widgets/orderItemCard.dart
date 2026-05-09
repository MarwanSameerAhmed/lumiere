import 'dart:convert';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const OrderItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildImage(),
          ),
          const SizedBox(width: 12),

          // تفاصيل المنتج
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']?.toString() ?? 'Product',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff2D3436),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${item['quantity'] ?? 1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          // السعر
          Text(
            '${_getPrice()} SAR',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xff243352),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final imageUrl = item['imageUrl']?.toString() ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      // Base64 image
      try {
        return Image.memory(
          base64Decode(imageUrl),
          width: 55,
          height: 55,
          fit: BoxFit.cover,
        );
      } catch (_) {
        return _buildPlaceholder();
      }
    } else if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: 55,
        height: 55,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xffF0EDE4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 24),
    );
  }

  String _getPrice() {
    final price = item['price'];
    if (price is num) {
      return price.toStringAsFixed(2);
    }
    return price?.toString() ?? '0.00';
  }
}
