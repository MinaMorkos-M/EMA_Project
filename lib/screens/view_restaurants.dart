import 'package:ema_project/models/place.dart';
import 'package:ema_project/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ViewRestaurants extends StatefulWidget {
  const ViewRestaurants({Key? key}) : super(key: key);

  @override
  State<ViewRestaurants> createState() => _ViewRestaurantsState();
}

class _ViewRestaurantsState extends State<ViewRestaurants> {
  List<Place>? places;
  getPlaces() async {
    places = await getRestaurants();
    setState(() {});
  }

  Future<List<Place>> getRestaurants() async {
    var url = 'https://mymobile.conveyor.cloud/api/restaurants';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['\$values'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

  @override
  void initState() {
    getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Restaurants'),
      ),
      body: (places != null)
          ? ListView.builder(
              itemCount: places!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Divider(),
                    ListTile(
                      title: Text(
                        places![index].name.toString(),
                      ),
                      subtitle: Text(
                          "${places![index].lat.toString()},${places![index].lng.toString()}"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.menu_book,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Products(places![index].id.toString()),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
    );
  }
}
