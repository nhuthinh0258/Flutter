import 'package:favorite_place/model/locationplace.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class Place {
  final String id;
  final String name;
  final File image;
  final LocationPlace location;
  Place({
    required this.name,
    required this.image,
    required this.location,
  }) : id = uuid.v4();
}
