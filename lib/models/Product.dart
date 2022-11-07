import 'package:flutter/material.dart';

class Product {
  String image, name, description, price, stock, id, address, category;
  int sold, toBuy;

  Product(
    this.id,
    this.image,
    this.name,
    this.description,
    this.stock,
    this.address,
    this.price,
    this.category,
    this.toBuy,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'description': description,
    'stock': stock,
    'address': address,
    'price': price,
    'category': category,
    'toBuy': toBuy,
  };
}
