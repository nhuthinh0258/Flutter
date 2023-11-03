import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';



//Dành cho provider Tĩnh

final mealProvider = Provider((ref){
  return dummyMeals;  //tạo một provider với giá trị ban đầu là danh sách dummyMeals.
});