import 'package:favorite_place/providers/user_place.dart';
import 'package:favorite_place/screen/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:favorite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesItem extends ConsumerWidget {
  const PlacesItem({super.key, required this.listPlace});

  final List<Place> listPlace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget item(context, index) {
      return Dismissible(
        key: ValueKey(listPlace[index].id),
        onDismissed: (direction) {
          ref.read(userPlaceProvider.notifier).removePlace(listPlace[index].id);
        },
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        ),
        child: InkWell(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListTile(
                title: Text(
                  listPlace[index].name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return PlaceDetailScreen(place: listPlace[index]);
            }));
          },
        ),
      );
    }

    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cactus.png',
            height: 100,
            width: 100,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Hiện không có địa điểm yêu thích',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75)),
          )
        ],
      ),
    );

    if (listPlace.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: listPlace.length,
        itemBuilder: item,
      );
    }

    return mainContent;
  }
}
