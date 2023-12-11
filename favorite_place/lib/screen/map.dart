import 'package:favorite_place/model/locationplace.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location =
          //Khai báo giá trị mặc định cho location trường hợp nếu ko có location được chọn
          const LocationPlace(address: '', lat: 37.422, long: -122.084),
      this.isSelecting = true});
  final LocationPlace location;
  final bool isSelecting;
  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Chọn vị trí' : 'vị trí của bản',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      //widget GoogleMap trong Flutter để hiển thị một bản đồ với một vị trí và marker cụ thể
      body: GoogleMap(
        //vị trí ban đầu của camera trên bản đồ
        initialCameraPosition: CameraPosition(
          //Điểm mục tiêu được thiết lập dựa trên vĩ độ và kinh độ
          target: LatLng(
            widget.location.lat,
            widget.location.long,
          ),
          //mức độ phóng to của camera
          zoom: 16,
        ),
        //tập hợp các Marker để hiển thị trên bản đồ.
        markers: {
          Marker(
            //Mỗi marker cần một ID duy nhất
            markerId:const MarkerId('md1'),
            // Đặt vị trí của marker dựa trên vĩ độ và kinh độ
            position: LatLng(
              widget.location.lat,
              widget.location.long,
            ),
          ),
        },
      ),
    );
  }
}
