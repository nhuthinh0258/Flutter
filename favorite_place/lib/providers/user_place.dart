import 'package:favorite_place/model/locationplace.dart';
import 'package:favorite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class UserPlaceNotifier extends StateNotifier<List<Place>>{
  UserPlaceNotifier() : super(const []);

  //Hàm xử lý thêm địa điểm
  void addPlace(String name,File image, LocationPlace location){
    final newPlace = Place(name: name,image: image,location: location);
    state = [newPlace,...state];
  }

  //Hàm xử lý xóa địa điểm
  void removePlace(String placeId){
    //where sẽ lọc ra tất cả các đối tượng Place mà id của chúng không bằng placeId được cung cấp. Nói cách khác, nó sẽ LOẠI BỎ đối 
    //tượng Place có id trùng với placeId
    state = state.where((place){
      return place.id != placeId;
    }).toList();
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier,List<Place>>((ref) {
  return UserPlaceNotifier();
});