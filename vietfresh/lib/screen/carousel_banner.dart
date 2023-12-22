import 'package:chat_app/screen/auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselBanner extends StatefulWidget {
  const CarouselBanner({super.key});

  @override
  State<CarouselBanner> createState() {
    return _CarouselBannerState();
  }
}

class _CarouselBannerState extends State<CarouselBanner> {
  late Future<List<String>> bannerImages;

  @override
  void initState() {
    super.initState();
    bannerImages = fetchBannerImages(); // Lấy ảnh khi widget được khởi tạo
  }

  Future<List<String>> fetchBannerImages() async {
    final bannerData = await firestore.collection('banner').get();
    List<String> imageUrls = [];
    for (var doc in bannerData.docs) {
      imageUrls.add(doc['image']);
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Connect to the stream of 'banner' collection
      stream: firestore.collection('banner').snapshots(),
      builder: (context, snapshot) {
        // Handling errors from Firebase
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        // Display loading indicator until the data is loaded
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // Extracting data from snapshot
        List banners = snapshot.data!.docs;

        // Convert documents into Image Widgets or any other widgets you want to display
        List<Widget> imageSliders = banners.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Image.network(
                  item[
                      'image'], // Assuming 'image' field contains the URL to the image
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          );
        }).toList();

        // Using these widgets in CarouselSlider
        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: imageSliders,
        );
      },
    );
  }
}
