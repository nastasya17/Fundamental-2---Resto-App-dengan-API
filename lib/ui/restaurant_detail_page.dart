import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_submission/data/api/api_service.dart';
import 'package:resto_app_submission/provider/resto_detail_provider.dart';
import '../widgets/card_detail_restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';
  final String id;

  const RestaurantDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoDetailProvider>(
      create: (_) =>
          RestoDetailProvider(detailapiService: ApiService(), id: id),
      child: Consumer<RestoDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Sedang memuat data restoran...',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.hasData) {
            return CardDetailRestaurant(restaurant: state.result!.restaurant);
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}
