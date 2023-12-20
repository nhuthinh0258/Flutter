import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/models/category.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/provider/load_category.dart';
import 'package:shopping_app/screens/item_detail.dart';
import 'package:shopping_app/screens/new_item.dart';
import 'package:shopping_app/widgets/products_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Groceries extends ConsumerStatefulWidget {
  const Groceries({super.key});

  @override
  ConsumerState<Groceries> createState() {
    return _GroceriesState();
  }
}

class _GroceriesState extends ConsumerState<Groceries> {
  List<GroceryItem> listGroceryItem = [];
  //Biến trạng thái "isLoading" cho thấy quá trình tải đang diễn ra
  var isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadItem();
  }

  //Hàm hiển thị, cập nhật danh sách sản phẩm từ firebase
  void loadItem() async {
    final categories = await ref.read(loadCategoryProvider.notifier).loadCategory();
    final url = Uri.https(
        'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'viet-fresh-user2/products.json');
    try {
      //http.get() -- yêu cầu lấy giữ liệu từ firebase
      final response = await http.get(url);
      //Trường hợp bị lỗi từ server, đặt trạng thái isLoading = false để hiển thị màn hình "CircularProgressIndicator()"
      if (response.body == 'null') {
        setState(() {
          isLoading = false;
        });
        //Lệnh return dùng để kết thúc hàm nhằm chặn thực thi các dòng code tiếp theo trong hàm
        return;
      }
      final Map<String, dynamic> listData = json.decode(response.body);
      //khởi tạo danh sách trống
      final List<GroceryItem> loadedProduct = [];
      //Duyệt từng bản ghi trong listData server
      for (final item in listData.entries) {
        //Tìm kiếm category của bản ghi tương ứng category của data
        final category = categories.firstWhere(
          (itemcat) => itemcat.id == item.value['category'],
          orElse: () => const Category(
              id: 'default', name: 'Không xác định', color: Colors.grey),
        );

        //Thêm sản phẩm vào danh sách
        loadedProduct.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            note: item.value['note'],
            category: category,
          ),
        );
      }
      setState(() {
        listGroceryItem = loadedProduct;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Đã xảy ra lỗi, vui lòng thử lại';
      });
    }
  }

  //Hàm addItem để chuyển tới layout "thêm sản phẩm"
  //addItem là một hàm async vì nó cần đợi màn hình "NewItem" trả về một "GroceryItem"
  void addItem() async {
    //await được sử dụng trước "Navigator.of(context).push(...)."" Điều này có nghĩa là mã sau lệnh await (phần kiểm tra và thêm newItem
    //vào danh sách) sẽ chỉ được thực thi sau khi màn hình NewItem đã đóng và trả về một "GroceryItem"
    final newitem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: ((ctx) {
          return const NewItem();
        }),
      ),
    );
    if (newitem == null) {
      return;
    }

    setState(() {
      listGroceryItem.add(newitem);
    });
  }

  //Hàm undo lại sản phẩm sau khi xóa
  void onUndo(GroceryItem product, int index) async {
    if (!context.mounted) return;

    final url = Uri.https(
        'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/viet-fresh-user2/products/${product.id}.json');
    final response = await http.put(url,
        body: json.encode({
          'name': product.name,
          'quantity': product.quantity,
          'note': product.note,
          'category': product.category.name,
        }));

    if (response.statusCode == 200) {
      setState(() {
        listGroceryItem.insert(index, product);
      });
    }
  }

  //Hàm xóa sản phẩm
  void onRemoveItem(GroceryItem product) async {
    final rmItem = listGroceryItem.indexOf(product);
    //Đường dẫn đến sản phẩm cụ thể gần xóa
    final url = Uri.https(
        'vietfresh-6acc6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'viet-fresh-user2/products/${product.id}.json');
    //biến response sẽ được gán sau khi hoàn thành yêu cầu xóa
    //http.delete - yêu cầu xóa
    final response = await http.delete(url);

    //Nếu trạng thái response hợp lệ
    if (response.statusCode == 200) {
      setState(() {
        listGroceryItem.remove(product);
      });
      // Kiểm tra xem context hiện tại có hợp lệ không
      if (!context.mounted) return;
      //Snackbar undo lại sản phẩm
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Đã xóa sản phẩm, Hoàn tác?'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            return onUndo(product, rmItem);
          },
        ),
      ));
    }
    //Nếu trạng thái response không hợp lệ
    else {
      // Kiểm tra xem context hiện tại có hợp lệ không
      if (!context.mounted) return;

      //Khôi phục lại sản phẩm khi response không hợp lệ
      setState(() {
        listGroceryItem.insert(rmItem, product);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Đã có lỗi, tạm thời không thể xóa'),
        ),
      );
    }
  }

  //Điều hướng đến trang chi tiết sản phẩm tương ứng
  void onSelectedProduct(GroceryItem product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((ctx) {
          return ItemDetail(
            product: product,
          );
        }),
      ),
    );
  }

  // void onUpdateItem(GroceryItem product) async {
  //   final updateItem = await Navigator.of(context).push<GroceryItem>(
  //     MaterialPageRoute(builder: (ctx) {
  //       return UpdateItem(
  //         product: product,
  //       );
  //     }),
  //   );
  //   if (updateItem != null) {
  //     setState(() {
  //       //Phương thức .indexWhere() là một phương thức của List, được sử dụng để tìm chỉ số (index) của phần tử đầu tiên trong danh
  //       //sách thỏa mãn một điều kiện nhất định
  //       final indexItem = listGroceryItem.indexWhere((index) {
  //         return index.id == updateItem.id;
  //       });
  //       //giá trị -1 thường được sử dụng để biểu thị rằng một tìm kiếm hoặc truy vấn không tìm thấy kết quả hợp lệ.
  //       //nếu tìm thấy phần tử trong danh sách (nghĩa là indexItem không phải là -1), thì thực hiện các hành động tiếp theo
  //       if (indexItem != -1) {
  //         listGroceryItem[indexItem] = updateItem;
  //       }
  //     });
  //   }
  // }

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
        onUpdateItem: (item) {},
        onRemoveItem: onRemoveItem,
        onSelectedItem: onSelectedProduct,
        listGroceryItem: listGroceryItem,
        isLoading: isLoading,
        error: error,
      ),
    );
  }
}
