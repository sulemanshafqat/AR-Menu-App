class Category {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  factory Category.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return Category(
      id: id,
      name: data["name"] ?? "",
    );
  }
}