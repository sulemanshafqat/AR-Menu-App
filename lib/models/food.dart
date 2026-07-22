class Food {
  final String id;
  final String name;
  final String description;
  final String image;
  final String price;
  final String rating;
  final String category;
  final bool arAvailable;
  final String modelUrl;
  final bool available;

  const Food({
    this.id = "",
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    required this.category,
    required this.arAvailable,
    this.modelUrl = "",
    this.available = true,
  });

  factory Food.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return Food(
      id: id,
      name: data["name"] ?? "",
      description: data["description"] ?? "",
      image: data["image"] ?? "",
      price: (data["price"] ?? 0).toString(),
rating: (data["rating"] ?? 4.8).toString(),
      category: data["categoryId"] ?? "",
      arAvailable: data["arAvailable"] ?? true,
      modelUrl: data["modelUrl"] ?? "",
      available: data["available"] ?? true,
    );
  }
}