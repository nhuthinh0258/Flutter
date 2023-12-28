import 'package:flutter/material.dart';

class CartIconWithBadge extends StatelessWidget {
  final int itemCount;

  const CartIconWithBadge({super.key,required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.shopping_cart), // Biểu tượng giỏ hàng
        if (itemCount > 0) // Chỉ hiển thị badge nếu có ít nhất một sản phẩm
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints:const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                itemCount.toString(), 
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
