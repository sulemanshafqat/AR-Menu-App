class MenuCategory {
  final String id;
  final String name;

  MenuCategory({
    required this.id,
    required this.name,
  });

  factory MenuCategory.fromMap(
      String id,
      Map<String, dynamic> data,
      ) {
    return MenuCategory(
      id: id,
      name: data["name"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
    };
  }
}