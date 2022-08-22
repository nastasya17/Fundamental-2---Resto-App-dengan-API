import 'package:flutter/material.dart';
import 'package:resto_app_submission/data/api/api_service.dart';
import 'package:resto_app_submission/data/model/restaurant_search.dart';

enum ResultState { loading, noData, hasData, error }

class RestoSearchProvider extends ChangeNotifier {
  final ApiService searchapiService;

  RestoSearchProvider({required this.searchapiService}) {
    fetchAllRestaurantSearch(search);
  }

  late RestaurantSearch? _restaurantsSearch;
  late ResultState? _state;

  String _message = '';
  String _search = '';

  String get messge => _message;

  RestaurantSearch? get result => _restaurantsSearch;

  String get search => _search;
  ResultState? get state => _state;

  Future<dynamic> fetchAllRestaurantSearch(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = ResultState.loading;
        _search = search;
        notifyListeners();

        final restaurant = await searchapiService.restaurantSearch(search);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Data tidak ditemukan';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantsSearch = restaurant;
        }
      } else {
        return _message = 'text null';
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Sambungkan dengan jaringan internet!';
    }
  }
}
