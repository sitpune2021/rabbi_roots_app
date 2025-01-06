class Category {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> subcategories; // Add subcategories

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.subcategories, // Add subcategories in constructor
  });
}
