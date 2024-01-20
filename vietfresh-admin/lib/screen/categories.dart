import 'package:admin/screen/auth_admin.dart';
import 'package:admin/screen/new_category.dart';
import 'package:admin/screen/update_categories.dart';
import 'package:admin/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories> {
  void addCategory() {
    //await đợi màn hình NewCategory() đóng rồi trả về kết quản newCategory
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return const NewCategory();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách loại sản phẩm'),
        actions: [
          IconButton(
            onPressed: () {
              firebase.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: addCategory,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: firestore.collection('category').snapshots(),
          builder: (ctx, cateSnapshot) {
            if (cateSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!cateSnapshot.hasData || cateSnapshot.data!.docs.isEmpty) {
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
                      'Hiện không có loại sản phẩm nào, hãy thêm sản phẩm!',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.75)),
                    )
                  ],
                ),
              );
            }
            final categories = cateSnapshot.data!.docs;
            return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (ctx, index) {
                  final category = categories[index].data();
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    color: Theme.of(context).primaryColorLight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ListTile(
                        leading: Row(
                          //Đảm bảo row chỉ chiếm đủ không gian cho các con của nó
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                color: Colors.grey,
                                width: 100,
                                height: 60,
                                child: category['image'] != null
                                    ? CachedNetworkImage(
                                        imageUrl: category['image'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                        title: Style(
                          outputText: category['name'],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) {
                                  return UpdateCategories(
                                      categories: category,
                                      currentImageUrl: category['image']);
                                }),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
