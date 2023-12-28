import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/cart.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/cart_icon.dart';

class VendorProductDetail extends StatefulWidget {
  const VendorProductDetail({super.key, required this.product});
  final Map<String, dynamic> product;

  @override
  State<VendorProductDetail> createState() {
    return _VendorProductDetail();
  }
}

class _VendorProductDetail extends State<VendorProductDetail> {
  String formatPrice(int price) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return '${formatCurrency.format(price)}₫';
  }

  void addToCart() async {
    final user = firebase.currentUser!;
    // Lấy thông tin giỏ hàng hiện tại
    final cartSnapshot = await firestore.collection('cart').doc(user.uid).get();

    //Tạo Danh Sách Sản Phẩm:
    List<dynamic> products = [];

    // Kiểm tra giỏ hàng có tồn tại không và khởi tạo 'products' nếu cần
    if (cartSnapshot.exists && cartSnapshot.data()?['products'] != null) {
      products = List.from(cartSnapshot.data()!['products']);
    }

    // Kiểm tra xem có sản phẩm nào từ nhà cung cấp khác không
    bool differentVendorExists = products.any((pro) {
      return pro['vendor_id'] != widget.product['vendor_id'];
    });

    // Nếu có sản phẩm từ nhà cung cấp khác
    if (differentVendorExists) {
      if (!mounted) return;
      // Hiển thị thông báo xác nhận
      final shouldReplace = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Thay đổi nhà cung cấp"),
              content: const Text(
                  "Giỏ hàng hiện tại chứa sản phẩm từ nhà cung cấp khác. Bạn có muốn xóa và thêm sản phẩm mới không?"),
              actions: [
                TextButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text("Không"),
                ),
                TextButton(
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                  child: const Text("Có"),
                ),
              ],
            );
          });

      // Nếu người dùng chọn thay thế sản phẩm
      if (shouldReplace ?? false) {
        products.clear(); // Xóa tất cả sản phẩm hiện có
        final newProduct = Map<String, dynamic>.from(widget.product);
        newProduct['quantity_buy'] = 1; // Khởi tạo quantity_buy là 1
        products.add(newProduct); // Thêm sản phẩm mới vào danh sách rỗng
        // Xóa tất cả sản phẩm và thêm sản phẩm mới
        await firestore.collection('cart').doc(user.uid).update({
          'user_id': user.uid,
          'products': products,
        });
        // Hiển thị thông báo
        if (!mounted) return;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Sản phẩm đã được thêm vào giỏ'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
                label: 'Đồng ý',
                onPressed: () {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).clearSnackBars();
                }),
          ),
        );
        return;
      }
    } else {
      bool productExists = false;
      //Duyệt Qua Danh Sách Sản Phẩm, cập nhật số lượng mua + 1 nếu sản phẩm đã có trong cart
      for (final pro in products) {
        if (pro['product_id'] == widget.product['product_id']) {
          pro['quantity_buy'] = (pro['quantity_buy'] ?? 0) + 1;
          productExists = true;
          break;
        }
      }
      //Thêm Sản Phẩm Mới Nếu Nó Chưa Tồn Tại
      if (!productExists) {
        final newProduct = Map<String, dynamic>.from(widget.product);
        newProduct['quantity_buy'] = 1; // Khởi tạo quantity_buy là 1
        products.add(newProduct);
      }
      //Cập Nhật Firestore:
      await firestore.collection('cart').doc(user.uid).set({
        'user_id': user.uid,
        'products': products,
      });
    }

    // Hiển thị thông báo
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sản phẩm đã được thêm vào giỏ'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Đồng ý',
            onPressed: () {
              if (!mounted) return;
              ScaffoldMessenger.of(context).clearSnackBars();
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product['name'],
        ),
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
            .doc(widget.product['product_id'])
            .snapshots(),
        builder: (ctx, detailSnapshot) {
          if (detailSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final detailData = detailSnapshot.data!.data();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorLight),
                  width: double.infinity,
                  height: 250,
                  child: CachedNetworkImage(
                    imageUrl: detailData!['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    detailData['name'],
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Khối lượng: ${detailData['kilo'].toString()}g',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder(
                    future: firestore
                        .collection('orgin')
                        .where('origin_id', isEqualTo: detailData['origin'])
                        .get(),
                    builder: (ctx, oriSnapshot) {
                      if (oriSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      final originItems = oriSnapshot.data!.docs.first.data();
                      return Text(
                        'Xuất xứ: ${originItems['name']}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Giá: ${formatPrice(detailData['price'])}',
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 226, 218, 218),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.pink,
                          onPressed: () {
                            if (firebase.currentUser == null) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const AuthScreen();
                              }));
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (firebase.currentUser == null) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const AuthScreen();
                                }));
                              } else {
                                addToCart();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColorLight),
                            child: const Text(
                              'Thêm vào giỏ',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (firebase.currentUser == null) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const AuthScreen();
                                }));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.error),
                            child: const Text(
                              'Mua Ngay',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
