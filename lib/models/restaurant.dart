class Restaurant {
  final String id;
  final String name;
  final String logo;
  final String description;

  Restaurant({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
  });

  factory Restaurant.fromMap(String id, Map<String, dynamic> data) {
    return Restaurant(
      id: id,
      name: data["name"] ?? "",
      logo: data["logo"] ?? "",
      description: data["description"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "logo": logo,
      "description": description,
    };
  }
}