import 'package:flutter/material.dart';
import '../data/model/restaurant_search.dart';
import '../ui/restaurant_detail_page.dart';


class CardSearchList extends StatelessWidget {
  final Restaurant restaurant;
  const CardSearchList({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => RestaurantDetailPage(id: restaurant.id)),
          ),
        );
      },
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      leading: Image.network(
        "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
        width: 120,
      ),
      title: Text(
        restaurant.name,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.place,
                size: 12,
              ),
              Text(restaurant.city),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 12,
              ),
              Text('${restaurant.rating}'),
            ],
          ),
        ],
      ),
    );
  }
}
