import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resto_app_submission/data/model/restaurant_details.dart';
import 'package:resto_app_submission/data/model/restaurant_search.dart';
import 'package:resto_app_submission/data/model/restaurant_list.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _search = 'search?q=';
  static const String _detail = 'detail/';
  static const String imgUrl = '${_baseUrl}images/medium/';

  Future<RestaurantList> listRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Memuat Data Restoran');
    }
  }
  
  Future<RestaurantSearch> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menampilkan hasil pencarian');
    }
  }

  Future<RestaurantDetails> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menampilkan detail restoran');
    }
  }
}