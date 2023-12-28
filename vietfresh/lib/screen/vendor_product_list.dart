import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/cart.dart';
import 'package:chat_app/screen/vendor_product_detail.dart';
import 'package:chat_app/style.dart';
import 'package:chat_app/style2.dart';
import 'package:chat_app/widgets/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VendorProductList extends StatelessWidget {
  const VendorProductList(
      {super.key, required this.vendor, required this.imageProvider});
  final Map<String, dynamic> vendor;
  final ImageProvider<Object> imageProvider;

  String formatPrice(int price) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return '${formatCurrency.format(price)}₫';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vendor['vendor_name']),
        actions: [
          if (firebase.currentUser != null)
            StreamBuilder(
                stream: firestore
                    .collection('cart')
                    .doc(firebase.currentUser!.uid)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData) {
                    final cartData = snapshot.data!.data();
                    List<dynamic> cartItems = cartData!['products'] ?? [];
                    int itemCount = cartItems.length;
                    return Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return const Cart();
                          }));
                        },
                        child: CartIconWithBadge(
                          itemCount: itemCount,
                        ),
                      ),
                    );
                  }
                  return IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const Cart();
                      }));
                    },
                  );
                }),
        ],
      ),
      body: StreamBuilder(
          stream: firestore
              .collection('product')
              .where('vendor_id', isEqualTo: vendor['user_id'])
              .snapshots(),
          builder: (ctx, proSnapshot) {
            if (proSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final productList = proSnapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight),
                    width: double.infinity,
                    height: 300,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Style(outputText: vendor['vendor_origin'])
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Style(
                                      outputText:
                                          vendor['vendor_phone'].toString())
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productList.length,
                        itemBuilder: (ctx, index) {
                          final product = productList[index].data();
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return VendorProductDetail(
                                        product: product);
                                  }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              outputText:
                                                  formatPrice(product['price']),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.red, // Màu nền nhẹ màu đỏ
                                          borderRadius: BorderRadius.circular(
                                              8), // Làm tròn góc
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            if (firebase.currentUser == null) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
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
                                height: 16,
                              ),
                            ],
                          );
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }
}

// ListView.builder(
//                 itemCount: productList.length,
//                 itemBuilder: (ctx, index) {
//                   final product = productList[index];
//                   return Column(
//                     children: [
//                       Image(image: imageProvider),
//                     ],
//                   );
//                 });
