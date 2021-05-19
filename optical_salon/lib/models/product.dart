import 'dart:ffi';

class Product{
  int id;
  String name;
  String brand;
  String model;
  String description;
  String cost;
  String country;
  String material;
  String photo;
  bool isFavorite;

  Product(this.id, this.name, this.brand, this.model, this.description, this.cost,
      this.country, this.material, this.photo, this.isFavorite);
}