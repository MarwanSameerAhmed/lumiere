class Products {
  final String Uid;
  final String ProductName;
  final String price;
  final String imageUrl;
  final String Description;
  final String CategoryId;
  final int stock;

  Products({
    required this.Uid,
    required this.ProductName,
    required this.price,
    required this.imageUrl,
    required this.Description,
    required this.CategoryId,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      "Uid": Uid,
      "ProductName": ProductName,
      "price": price,
      "imageUrl": imageUrl,
      "Description": Description,
      "CategoryId": CategoryId,
      "stock": stock,
    };
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      Uid: json['Uid']?.toString() ?? "",
      ProductName: json['ProductName']?.toString() ?? "",
      price: json['price']?.toString() ?? "",
      imageUrl: json['imageUrl']?.toString() ?? "",
      Description: json['Description'] ?? "",
      CategoryId: json['CategoryId']?.toString() ?? "",
      stock: (json['stock'] is int) ? json['stock'] : 0,
    );
  }
}
