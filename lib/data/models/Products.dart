import 'dart:convert';
import 'package:c_route_task/bussiness_logih/Bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double oldPrice;
  final double rating;
  final String thumbnail;
  final double discountPercentage;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.thumbnail,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      oldPrice: json['oldPrice'] != null ? json['oldPrice'].toDouble() : 0,
      rating: json['rating'].toDouble(),
      thumbnail: json['thumbnail'],
      discountPercentage: json['discountPercentage'],
    );
  }
}
