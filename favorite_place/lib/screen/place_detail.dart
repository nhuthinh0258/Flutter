import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_place/model/place.dart';

class PlaceDetailScreen extends ConsumerWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body:Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  place.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
