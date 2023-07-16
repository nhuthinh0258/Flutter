import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/widget/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

    String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          //thuộc tính shape được sử dụng để xác định hình dạng của một widget,
          borderRadius: BorderRadius.circular(
              8) //với RoundedRectangleBorder, nó tạo ra một đường viền hình chữ nhật với các góc được bo tròn.
          ),
      clipBehavior: Clip
          .hardEdge, //sử dụng để xác định cách widget xử lý việc cắt bớt nội dung khi vượt quá ranh giới của nó,Giá trị Clip.hardEdge được sử dụng để cắt bớt nội dung một cách cứng nhắc, không làm mờ hay làm mịn các góc cạnh.
      margin: const EdgeInsets.all(8),
      elevation:
          2, //xác định độ nổi của một widget trong giao diện, giá trị càng lớn độ nổi càng cao
      child: InkWell(
        onTap: (){
          onSelectMeal(meal);
        },
        child: Stack(
          //sử dụng để xếp chồng các widget lên nhau. Nó cho phép định vị các widget con theo tọa độ tương đối hoặc tuyệt đối và hiển thị chúng lên màn hình
          children: [
            FadeInImage(
              //hiển thị một hình ảnh trong quá trình nạp dữ liệu.
              placeholder: MemoryImage(
                  kTransparentImage), // Hình ảnh tạm thời, ở đây là một hình ảnh trong suốt
              image:
                  NetworkImage(meal.imageUrl), // Đường dẫn đến hình ảnh chính
              fit: BoxFit
                  .cover, //xác định cách hiển thị nội dung của một widget trong một không gian giới hạn, ở đây sẽ được tự động co dãn mà vẫn giữ ti lệ gốc
              width: double
                  .infinity, //Ảnh sẽ chiếm hết không gian theo chiều ngang nhiều nhất có thể
              height: 200,
            ),
            Positioned(
              bottom: 0, //Vị trí dưới cùng
              left: 0, //lấp đầy bên trái
              right: 0, //lấp đầy bên phải
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    //Tiêu đề món ăn
                    Text(
                      meal.title,
                      maxLines: 2, // hiển thị tối đa 2 dòng
                      textAlign: TextAlign.center,
                      softWrap:
                          true, //văn bản sẽ tự động wrap xuống dòng khi nó vượt quá kích thước của widget
                      overflow: TextOverflow
                          .ellipsis, //nếu văn bản vượt quá kích thước của widget, các ký tự cuối cùng sẽ được thay thế bằng dấu chấm ba (...)
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
