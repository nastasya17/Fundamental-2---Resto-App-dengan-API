import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_submission/widgets/card_search_list.dart';
import '../data/api/api_service.dart';
import '../provider/resto_search_provider.dart';
import '../widgets/card_search_list.dart';

class RestaurantSearchPage extends StatefulWidget {
  final routeName = '/search';
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoSearchProvider>(
      create: (_) => RestoSearchProvider(searchapiService: ApiService()),
      child: Consumer<RestoSearchProvider>(builder: (context, state, _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.only(right: 3),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(190, 150, 150, 150),
                                  offset: Offset(1, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 5),
                                    child: TextField(
                                      controller: _controller,
                                      onChanged: (String value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            keyword = value;
                                          });
                                          if (value != '') {
                                            state.fetchAllRestaurantSearch(
                                                value);
                                          }
                                        }
                                      },
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                      decoration: InputDecoration(
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.23)),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (keyword.isEmpty)
                      ? const Center(
                          child: Text('Mulai Pencarian'),
                        )
                      : Consumer<RestoSearchProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.loading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state.state == ResultState.hasData) {
                              state.fetchAllRestaurantSearch(keyword);
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.result!.restaurants.length,
                                itemBuilder: (context, index) {
                                  var restaurant =
                                      state.result!.restaurants[index];
                                  return CardSearchList(restaurant: restaurant);
                                },
                              );
                            } else if (state.state == ResultState.noData) {
                              state.fetchAllRestaurantSearch(keyword);
                              return Center(child: Text(state.messge));
                            } else if (state.state == ResultState.error) {
                              return Center(child: Text(state.messge));
                            } else {
                              return const Center(child: Text(''));
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
