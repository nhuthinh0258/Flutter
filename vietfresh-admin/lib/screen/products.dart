import 'package:admin/screen/update_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../provider/bottom_navigation_provider.dart';
import '../style.dart';
import '../style2.dart';
import 'auth_admin.dart';
import 'new_category.dart';
import 'new_products.dart';

class Product extends ConsumerStatefulWidget {
  const Product({
    super.key,
  });
  @override
  ConsumerState<Product> createState() {
    return _Product();
  }
}

class _Product extends ConsumerState<Product> {
  var searchQuery = ""; // Từ khóa tìm kiếm
  List<dynamic> filteredProducts = []; // Danh sách sản phẩm đã lọc
  List<Map<String, dynamic>> allProducts = [];
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    // Thêm listener
    myFocusNode.addListener(onFocusChange);
  }

  void onFocusChange() {
    if (myFocusNode.hasFocus) {
      ref.read(bottomNavigationProvider.notifier).hide();
    } else {
      ref.read(bottomNavigationProvider.notifier).show();
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  void addProduct() {
    //await đợi màn hình NewCategory() đóng rồi trả về kết quản newCategory
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return const NewProduct();
        },
      ),
    );
  }

  String formatPrice(int price) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return '${formatCurrency.format(price)}₫';
  }

  //Hàm xóa sản phẩm cùng với ảnh
  void onDeleteProduct(String productId, String productImage) async {
    // Xóa sản phẩm từ Firestore
    await firestore.collection('product').doc(productId).delete();
    // Xóa ảnh từ Storage
    await firebaseStorage.refFromURL(productImage).delete();

    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sản phẩm đã được xóa'),
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
        title: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8), // Điều chỉnh padding nếu cần
          decoration: BoxDecoration(
            color: Colors.white, // Đặt màu nền cho TextField
            borderRadius: BorderRadius.circular(20), // Làm tròn góc nếu muốn
          ),
          child: TextField(
            focusNode: myFocusNode,
            onChanged: updateSearchQuery,
            decoration: const InputDecoration(
              hintText: "Tìm kiếm sản phẩm...",
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Colors.grey), // Điều chỉnh màu sắc hint text nếu cần
            ),
            style: const TextStyle(
                color: Colors.black, fontSize: 14), // Điều chỉnh màu sắc text
          ),
        ),
        actions: [
          IconButton(
            onPressed: addProduct,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: firestore
              .collection('product')
              .orderBy('sort_timestamp', descending: true)
              .snapshots(),
          builder: (ctx, productSnapshot) {
            if (productSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!productSnapshot.hasData ||
                productSnapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/cactus.png',
                        width: 100,
                        height: 100,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.75)),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Hiện không có sản phẩm nào, hãy thêm sản phẩm!',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.75)),
                    )
                  ],
                ),
              );
            }
            if (productSnapshot.hasError) {
              return Text("Error: ${productSnapshot.error}");
            }
            final productsItem = productSnapshot.data!.docs;
            final filteredProducts = searchQuery.isEmpty
                ? productsItem
                : productsItem.where((product) {
                    return (product['name'].toString())
                        .toLowerCase()
                        .contains(searchQuery);
                  }).toList();
            return ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (ctx, index) {
                  final product = filteredProducts[index].data();
                  return Dismissible(
                    key: Key(product['product_id']),
                    background: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 10),
                      color:
                          Theme.of(context).colorScheme.error.withOpacity(0.5),
                    ),
                    onDismissed: (direction) {
                      onDeleteProduct(product['product_id'], product['image']);
                      filteredProducts.removeAt(index);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 5),
                      color: Theme.of(context).primaryColorLight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  color: Colors.grey,
                                  width: 100,
                                  height: 60,
                                  child: product['image'] != null
                                      ? CachedNetworkImage(
                                          imageUrl: product['image'],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          title: Style(outputText: product['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Style2(
                                outputText:
                                    'Giá: ${formatPrice(product['price'])}',
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Style2(outputText: ' ${product['user']}')
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => UpdateProduct(
                                      product: product, // Dữ liệu sản phẩm
                                      currentImageUrl: product[
                                          'image'], // URL của ảnh hiện tại
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
