
class Product{
  static const ID = "id";
  static const CATEGORY = "category";
  static const NAME = "name";
  static const PRICE = "price";
  static const BRAND = "brand";
  static const COLORS = "colors";
  static const QUANTITY = "quantity";
  static const SIZES = "sizes";
  static const SALE = "sale";
    static const FEATURED = "featured";
  static const PICTURE = "picture";


  String id;
  String name;
  String brand;
  String category;
  String picture;
  double price;
  int quantity;
  List colors;
  List sizes;
  List similarProducts;

  @override
  String toString() {
    return 'Product{_id: $id, _name: $name, _brand: $brand, _category: $category, _picture: $picture, _price: $price, _quantity: $quantity, _colors: $colors, _sizes: $sizes, _onSale: $onSale, _featured: $featured}';
  }

  bool onSale;
  bool featured;


  Product({this.id, this.name, this.brand, this.category, this.picture,
      this.price, this.quantity, this.colors, this.sizes, this.onSale,
      this.featured,
      this.similarProducts});


}