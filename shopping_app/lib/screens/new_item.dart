
import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/new_items.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});
  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
} 
class _NewItemState extends State<NewItem>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm mới'),
      ),
      body: const NewItems(),
    );
  }
}