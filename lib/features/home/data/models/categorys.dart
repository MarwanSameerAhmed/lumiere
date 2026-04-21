class Categorys {
  final String ID;
  final String name;
  final String icon;

  Categorys({required this.ID, required this.name, required this.icon});

  Map<String, dynamic> toMap() {
    return {"ID": ID, "name": name, "icon": icon};
  }

  factory Categorys.fromJson(Map<String, dynamic> json) {
    return Categorys(ID: json['ID'], name: json["name"], icon: json["icon"]);
  }
}
