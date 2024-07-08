// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String name;
  String? description;
  int price;
  String? category;
  List<String> images;
  int rating;
  int quantity;
  bool isAvailable;
  bool isFavorite;
  int off;
  TextEditingController priceControlller = TextEditingController();
  ProductModel({
    this.id,
    required this.name,
    this.description,
    required this.price,
    this.category,
    required this.images,
    required this.rating,
    required this.isAvailable,
    required this.quantity,
    required this.isFavorite,
    required this.off,
    required this.priceControlller,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'images': images.map((x) => x).toList(),
      'rating': rating,
      'quantity': quantity,
      'isAvailable': isAvailable,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      category: map['category'] as String,
      images: map['images'] as List<String>,
      rating: map['rating'] as int,
      off: map['off'] as int,
      quantity: map['quantity'] as int,
      isAvailable: map['isAvailable'] as bool,
      isFavorite: map['isFavorite'] as bool,
      priceControlller: TextEditingController(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
