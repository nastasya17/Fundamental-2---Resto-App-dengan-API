import 'package:flutter/material.dart';
import '../data/model/restaurant_list.dart';
import '../ui/restaurant_detail_page.dart';

class CardListRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardListRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
            width: 120,
          ),
        ),
      ),
      title: Text(restaurant.name,style: Theme.of(context).textTheme.headline6,),
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => RestaurantDetailPage(id: restaurant.id)),
          ),
        );
      },
    );
  }
}
