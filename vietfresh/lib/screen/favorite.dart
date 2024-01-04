import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/vendor_product_detail.dart';
import 'package:flutter/material.dart';

import '../style.dart';
import '../widgets/cart_icon.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final user = firebase.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        centerTitle: true,
        actions: [
          if (user != null) const CartIconWithBadge(),
        ],
      ),
      body: StreamBuilder(
        stream: firestore.collection('favorite').doc(user!.uid).snapshots(),
        builder: (ctx, favoriteSnap) {
          if (favoriteSnap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!favoriteSnap.hasData ||
              favoriteSnap.data!.data() == null ||
              favoriteSnap.data!.data()?['products'] == null ||
              (favoriteSnap.data!.data()!['products'] as List).isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/cactus.png',
                      width: 100,
                      height: 100,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.75)),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Hiện không có sản phẩm nào',
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.75)),
                  )
                ],
              ),
            );
          }
          final favoriteData = favoriteSnap.data!.data();
          final favoriteProducts = favoriteData!['products'] as List;
          return ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (ctx, index) {
                final favoriteProduct = favoriteProducts[index];
                return Column(
                  children: [
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                          return VendorProductDetail(product: favoriteProduct);
                        }));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                width: 100,
                                height: 100,
                                child: favoriteProduct['image'] != null
                                    ? CachedNetworkImage(
                                        imageUrl: favoriteProduct['image'],
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Style(
                                    outputText: favoriteProduct['name'],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                );
              });
        },
      ),
    );
  }
}
