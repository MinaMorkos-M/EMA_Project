class Product {
  int? id;
  String? name;
  int? price;

  Product({
    this.id,
    this.name,
    this.price,
  });
  factory Product.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Product(
        id: parsedJson['id'],
        name: parsedJson['name'],
        price: parsedJson['price']);
  }
}
