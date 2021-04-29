import 'package:flutter/material.dart';
import 'package:animated_product_presentation/travel_concept_page.dart';

class BikeConceptDetailPage extends StatelessWidget {
  final LocationCard location;

  const BikeConceptDetailPage({Key key, this.location}) : super(key: key);

  void _onVerticalDrag(
    DragUpdateDetails details,
    BuildContext context,
  ) {
    if (details.primaryDelta > 3.0) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onVerticalDragUpdate: (details) =>
                _onVerticalDrag(details, context),
            child: Hero(
              tag: location.title,
              child: Image.network(
                location.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...List.generate((20), (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(avatars.last),
                  radius: 15,
                ),
                title: Text(location.title),
                subtitle: Text(
                    'Reviews from buyer $index \n Must Buy \n Recomonded'),
              ),
            );
          })
        ],
      ),
    );
  }
}
