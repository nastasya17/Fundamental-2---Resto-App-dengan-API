import 'package:flutter/material.dart';
import 'package:resto_app_submission/data/api/api_service.dart';
import 'package:resto_app_submission/data/model/restaurant_list.dart';

enum ResultState { loading, noData, hasData, error }

class RestoListProvider extends ChangeNotifier {
  final ApiService listapiService;
  final String id;
  
  RestoListProvider({
    required this.listapiService, required this.id}) {
    _fetchAllRestaurants();
  }

  late RestaurantList? _restaurantList;
  late ResultState? _state;
  String _message = '';

  String get message => _message;
  RestaurantList? get result => _restaurantList;
  ResultState? get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await listapiService.listRestaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList= restaurant;
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Sambungkan dengan jaringan internet!';
    }
  }
}

