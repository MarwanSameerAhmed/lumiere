class Products {
  final String Uid;
  final String ProductName;
  final String price;
  final String imageUrl;
  final String CategoryId;
  final int stock;

  Products({
    required this.Uid,
    required this.ProductName,
    required this.price,
    required this.imageUrl,
    required this.CategoryId,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      "Uid": Uid,
      "ProductName": ProductName,
      "price": price,
      "imageUrl": imageUrl,
      "CategoryId": CategoryId,
      "stock": stock,
    };
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      Uid: json['Uid'],
      ProductName: json['ProductName'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      CategoryId: json['categoryId'],
      stock: json['stock'],
    );
  }
}
