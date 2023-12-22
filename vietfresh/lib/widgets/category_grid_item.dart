import 'package:chat_app/screen/auth.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('category').snapshots(),
      builder: (ctx, cateSnapshot) {
        if (!cateSnapshot.hasData) return const CircularProgressIndicator();
        final categories = cateSnapshot.data!.docs;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          height: 220, // Adjust the height accordingly
          child: GridView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns
                childAspectRatio: 1,
              ),
              itemBuilder: (ctx, index) {
                final category = categories[index].data();
                return Card(
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              color: Colors.grey,
                              height: 70,
                              width: 100,
                              child: category['image'] != null
                                  ? Image.network(
                                      categories[index]['image'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        Text(category['name']),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
