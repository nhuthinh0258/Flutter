import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/vendor_list_home.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key});

  // Bước 1: Truy Vấn Sản Phẩm Theo Category
  void fetchVendorsByCategory(Map<String, dynamic> category, BuildContext context) async {
    String categoryId = category['category_id'];
    //Lấy dữ liệu sản phẩm với điều kiện trùng với loại sản phẩm được chọn
    final productsSnapshot = await firestore
        .collection('product')
        .where('category', isEqualTo: categoryId)
        .get();

    // Bước 2: Thu Thập Vendor IDs
    //khởi tạo 1 set String
    final Set<String> vendorIds = {};
    final List<Map<String, dynamic>> vendorList = [];
    //Duyệt qua từng sản phẩm trong productsSnapshot
    for (final product in productsSnapshot.docs) {
      //Lưu dữ liệu vào set vendorIds thông qua id vendor của sản phẩm, nếu nhiều hơn 2 id trùng nhau thì chỉ lấy 1
      vendorIds.add(product.data()['vendor_id']);
    }

    // Bước 3: Truy Vấn và Hiển Thị Thông Tin Vendor

    for (final vendorId in vendorIds) {
      final vendorSnapshot =
          await firestore.collection('vendor').doc(vendorId).get();
      final vendorData = vendorSnapshot.data();
      if (vendorData != null) {
        vendorList.add(vendorData);
      }
    }
    if (!context.mounted) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return VendorListHome(
        category: category,
        vendorList: vendorList,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('category').limit(8).snapshots(),
      builder: (ctx, cateSnapshot) {
        if (!cateSnapshot.hasData) return const CircularProgressIndicator();
        final categories = cateSnapshot.data!.docs;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GridView.builder(
              //Đặt kích thước của GridView chỉ chiếm đủ nội dung bên trong
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns
                childAspectRatio: 1,
              ),
              itemBuilder: (ctx, index) {
                final category = categories[index].data();
                return GestureDetector(
                  onTap: () {
                    fetchVendorsByCategory(category, context);
                  },
                  child: Card(
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                color: Colors.grey,
                                child: category['image'] != null
                                    ? CachedNetworkImage(
                                        imageUrl: category['image'],
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          Text(category['name']),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
