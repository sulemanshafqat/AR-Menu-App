class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String modelUrl;
  final bool available;
  final String categoryId;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.modelUrl,
    required this.available,
    required this.categoryId,
  });

  factory MenuItem.fromMap(
      String id,
      Map<String, dynamic> data,
      ) {
    return MenuItem(
      id: id,
      name: data["name"] ?? "",
      description: data["description"] ?? "",
      price: (data["price"] ?? 0).toDouble(),
      image: data["image"] ?? "",
      modelUrl: data["modelUrl"] ?? "",
      available: data["available"] ?? true,
      categoryId: data["categoryId"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "image": image,
      "modelUrl": modelUrl,
      "available": available,
      "categoryId": categoryId,
    };
  }
}