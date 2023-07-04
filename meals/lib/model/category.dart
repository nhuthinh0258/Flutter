import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, //Màu mặc định là màu cam
  });

  
  final String id;
  final String title;
  final Color color;
}
