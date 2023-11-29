import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/screens/item_detail.dart';
import 'package:shopping_app/screens/new_item.dart';
import 'package:shopping_app/widgets/category_item.dart';

class Groceries extends StatefulWidget {
  const Groceries({super.key});

  @override
  State<Groceries> createState() {
    return _GroceriesState();
  }
}

class _GroceriesState extends State<Groceries> {
  
  //Hàm addItem để chuyển tới layout "thêm sản phẩm"
  void addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((ctx) {
          return const NewItem();
        }),
      ),
    );
  }

  //Điều hướng đến trang chi tiết sản phẩm tương ứng
  void onSelectedProduct(GroceryItem product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((ctx) {
          return ItemDetail(product: product,);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var activePageTittle = "Sản phẩm của bạn";
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTittle),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: CategoryItem(
        onSelectedItem: onSelectedProduct,
      ),
    );
  }
}
