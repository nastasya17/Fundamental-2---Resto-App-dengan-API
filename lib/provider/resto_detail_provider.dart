import 'package:resto_app_submission/data/api/api_service.dart';
import 'package:resto_app_submission/data/model/restaurant_details.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class RestoDetailProvider extends ChangeNotifier {
  final ApiService detailapiService;
  final String id;

  RestoDetailProvider({required this.detailapiService, required this.id}) {
    _fetchAllRestaurantDetail();
  }

  late RestaurantDetails? _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetails? get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurantDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantDetails = await detailapiService.getDetailRestaurant(id);
      if (restaurantDetails.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data tidak dapat ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetails;
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Sambungkan dengan jaringan internet!';
    }
  }
}
