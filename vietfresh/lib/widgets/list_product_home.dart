import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/vendor_product_detail.dart';
import 'package:chat_app/style.dart';
import 'package:chat_app/style2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListProductHome extends StatelessWidget {
  const ListProductHome({super.key});

  String formatPrice(int price) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return '${formatCurrency.format(price)}₫';
  }

  // Hàm chọn ngẫu nhiên một số phần tử từ list
  List getRandomElements(List list, int count) {
    final random = Random();
    // Đảm bảo không chọn quá số lượng có trong list
    count = min(count, list.length);
    final randomElements = <dynamic>{};
    while (randomElements.length < count) {
      final randomIndex = random.nextInt(list.length);
      randomElements.add(list[randomIndex]);
    }
    return randomElements.toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore.collection('product').snapshots(),
        builder: (ctx, proSnapshot) {
          if (proSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!proSnapshot.hasData || proSnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Hiện không có sản phẩm'),
            );
          }
          if (proSnapshot.hasError) {
            return const Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          final products = proSnapshot.data!.docs;
          final randomProduct = getRandomElements(products, 3);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: randomProduct.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  final product = randomProduct[index].data();
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                            return VendorProductDetail(product: product);
                          }));
                        },
                        child: Container(
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
                                  child: product['image'] != null
                                      ? CachedNetworkImage(
                                          imageUrl: product['image'],
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
                                      outputText: product['name'],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Style2(
                                        outputText:
                                            '${product['kilo'].toString()}g'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Style2(
                                      outputText: formatPrice(product['price']),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red, // Màu nền nhẹ màu đỏ
                                  borderRadius:
                                      BorderRadius.circular(8), // Làm tròn góc
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (firebase.currentUser == null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return const AuthScreen();
                                      }));
                                    }
                                  },
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
