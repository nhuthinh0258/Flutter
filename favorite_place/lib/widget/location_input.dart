import 'dart:convert';

import 'package:favorite_place/model/locationplace.dart';
import 'package:favorite_place/screen/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectedLocation});

  final void Function(LocationPlace location) onSelectedLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  //biến có thể null, lưu trữ thông tin về vị trí đã chọn, bao gồm vĩ độ và kinh độ
  LocationPlace? pickedLocation;
  var isGettingLocation = false;

  void savePlace(double lat, double long) async{
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyCqQtAnVK7DJBTaKAm3e2Qsp4R1QN4jkuo');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];
    //Cập nhật Trạng thái UI với Vị trí Đã Lấy
    setState(() {
      pickedLocation = LocationPlace(
        address: address,
        lat: lat,
        long: long,
      );
      isGettingLocation = false;
    });
    widget.onSelectedLocation(pickedLocation!);
  }

  //tạo URL cho một bản đồ tĩnh từ Google Static Maps API dựa trên vị trí đã chọn pickedLocation
  String get locationImage {
    //Nếu null, nó trả về một chuỗi rỗng, có nghĩa là không có URL bản đồ nào được tạo
    if (pickedLocation == null) {
      return '';
    }
    final lat = pickedLocation!.lat;
    final long = pickedLocation!.long;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=&zoom=16&size=600x300&maptype=roadmap&markers=color:green%7Clabel:A%7C$lat,$long&key=AIzaSyCqQtAnVK7DJBTaKAm3e2Qsp4R1QN4jkuo';
  }

  //Hàm lấy vị trí
  void getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    //Kiểm tra và Yêu cầu Dịch vụ Vị trí
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    //Kiểm tra và Yêu cầu Quyền Truy cập Vị trí
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    //Bắt đầu Lấy Vị trí
    setState(() {
      isGettingLocation = true;
    });
    //Lấy Vị trí Hiện tại
    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;
    //Kiểm tra Vị trí Hợp lệ
    if (lat == null || long == null) {
      return;
    }
    //Lấy Địa chỉ từ Google Geocoding API
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyCqQtAnVK7DJBTaKAm3e2Qsp4R1QN4jkuo');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];
    //Cập nhật Trạng thái UI với Vị trí Đã Lấy
    setState(() {
      pickedLocation = LocationPlace(
        address: address,
        lat: lat,
        long: long,
      );
      isGettingLocation = false;
    });
    widget.onSelectedLocation(pickedLocation!);
  }

  void onSelectLocation() async {
    final selectingLocation = await Navigator.of(context)
        .push<LatLng>(MaterialPageRoute(builder: (ctx) {
      return const MapScreen();
    }));
    if (selectingLocation == null) {
      return;
    }
    savePlace(selectingLocation.latitude, selectingLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'Không có địa điểm được chọn',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    //Nếu pickedLocation ko null, nó sẽ hiển thị thay cho text hình ảnh map url
    if (pickedLocation != null) {
      content = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    //khi lấy vị trí sẽ được thay thế bằng màn hình vòng tròn tải
    if (isGettingLocation) {
      content = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          child: content,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_city),
              label: const Text('Địa chỉ hiện tại'),
            ),
            ElevatedButton.icon(
              onPressed: onSelectLocation,
              icon: const Icon(Icons.map),
              label: const Text('Chọn địa chỉ'),
            ),
          ],
        )
      ],
    );
  }
}
