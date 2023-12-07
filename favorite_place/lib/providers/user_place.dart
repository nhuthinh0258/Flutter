import 'package:favorite_place/model/place.dart';
import 'package:riverpod/riverpod.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>>{
  UserPlaceNotifier() : super(const []);

  //Hàm xử lý thêm địa điểm
  void addPlace(String name){
    final newPlace = Place(name: name);
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