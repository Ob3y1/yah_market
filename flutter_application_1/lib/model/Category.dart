class Category {
  final String name;
  final List<Product> products;

  Category({required this.name, required this.products});
}

class Product {
  final String name;
  final String description;
  final double price;

  Product({required this.name, required this.description, required this.price});
}
