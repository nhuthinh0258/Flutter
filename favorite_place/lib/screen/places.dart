import 'package:favorite_place/providers/user_place.dart';
import 'package:favorite_place/screen/new_place.dart';
import 'package:favorite_place/widget/places_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlaceProvider);
    
    void addButon() {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const NewPlaceScreen();
      }));
    }

    var activePageTittle = "địa điểm của bạn";
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTittle),
        actions: [
          IconButton(
            onPressed: addButon,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: PlacesItem(
          listPlace: userPlaces,
        ),
      ),
    );
  }
}
