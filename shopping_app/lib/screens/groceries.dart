import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/screens/item_detail.dart';
import 'package:shopping_app/screens/new_item.dart';
import 'package:shopping_app/screens/update_item.dart';
import 'package:shopping_app/widgets/category_item.dart';

class Groceries extends StatefulWidget {
  const Groceries({super.key});
  

  @override
  State<Groceries> createState() {
    return _GroceriesState();
  }
}

class _GroceriesState extends State<Groceries> {
  final List<GroceryItem> listGroceryItem = [];
  
  //Hàm addItem để chuyển tới layout "thêm sản phẩm"
  //addItem là một hàm async vì nó cần đợi màn hình "NewItem" trả về một "GroceryItem"
  void addItem() async {
    //await được sử dụng trước "Navigator.of(context).push(...)."" Điều này có nghĩa là mã sau lệnh await (phần kiểm tra và thêm newItem 
    //vào danh sách) sẽ chỉ được thực thi sau khi màn hình NewItem đã đóng và trả về một "GroceryItem"
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: ((ctx) {
          return const NewItem();
        }),
      ),
    );

    //Nếu có 1 sản phẩm mới thì sẽ được thêm vào list và cập nhật lại trạng thái
    if (newItem != null){
      setState(() {
        listGroceryItem.add(newItem);
      });
    }
  }

  void onRemoveItem(GroceryItem product){
    final rmItem = listGroceryItem.indexOf(product);
    setState(() {
      listGroceryItem.remove(product);
    });
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

  void onUpdateItem(GroceryItem product) async {
    final updateItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) {
        return UpdateItem(
          product: product,
        );
      }),
    );
    if (updateItem != null) {
      setState(() {
        final indexItem = listGroceryItem.indexWhere((index) {
          return index.id == updateItem.id;
        });
        if (indexItem != -1) {
          listGroceryItem[indexItem]= updateItem;
        }
      });
    }
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
        onUpdateItem: onUpdateItem,
        onRemoveItem: onRemoveItem,
        onSelectedItem: onSelectedProduct,
        listGroceryItem: listGroceryItem,
      ),
    );
  }
}
