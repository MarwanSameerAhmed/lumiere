class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "price": price,
      "quantity": quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      imageUrl: json["imageUrl"]?.toString() ?? "",
      price: (json["price"] is num)
          ? (json["price"] as num).toDouble()
          : double.tryParse(json["price"]?.toString() ?? "0") ?? 0.0,
      quantity: (json["quantity"] is int)
          ? json["quantity"]
          : int.tryParse(json["quantity"]?.toString() ?? "1") ?? 1,
    );
  }

  // نسخة معدلة من العنصر
  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
