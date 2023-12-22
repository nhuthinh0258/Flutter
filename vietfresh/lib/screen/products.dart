import 'package:chat_app/screen/new_product.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() {
    return _Product();
  }
}

class _Product extends State<Product> {

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        actions: [
          IconButton(
            onPressed: addProduct,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
