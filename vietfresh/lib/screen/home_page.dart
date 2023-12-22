import 'package:chat_app/screen/carousel_banner.dart';
import 'package:chat_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> products = [
      "Product 1",
      "Product 2",
      "Product 3",
      "Product 4"
    ]; // Replace with your product data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Slide Banner
            const SizedBox(
              height: 8,
            ),
            const CarouselBanner(),
            const SizedBox(
              height: 8,
            ),
            // 2. Categories Selection
            const CategoryGridItem(),

            // 3. List of All Products
            ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // to disable ListView's scrolling
              shrinkWrap: true, // Use this to fit ListView into Column
              itemCount: products.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(products[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
