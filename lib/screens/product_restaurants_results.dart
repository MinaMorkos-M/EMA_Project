import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ema_project/models/location_helper.dart';
import 'package:ema_project/models/place.dart';
import 'package:flutter/material.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductRestaurantsResults extends StatefulWidget {
  final String? searchValue;
  ProductRestaurantsResults(this.searchValue);
  @override
  State<ProductRestaurantsResults> createState() =>
      _ProductRestaurantsResultsState();
}

class _ProductRestaurantsResultsState extends State<ProductRestaurantsResults> {
  List<Place>? places;
  static Position? position;
  bool showButton = false;
  StreamSubscription? subscription;

  getCurrentLocation() async {
    try {
      position = await LocationHelper.getCurrentLocation();

      if (subscription != null) {
        subscription!.cancel();
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  getPlaces(String val) async {
    places = await getRestaurants(val);
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<List<Place>> getRestaurants(String val) async {
    var url = 'https://mymobile.conveyor.cloud/api/products/$val';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['\$values'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

  @override
  void initState() {
    getCurrentLocation();
    getPlaces(widget.searchValue.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available at"),
      ),
      body: (places != null && position != null)
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
                        icon: Icon(Icons.place),
                        onPressed: () {
                          double distance = calculateDistance(
                            places![index].lat,
                            places![index].lng,
                            position!.latitude,
                            position!.longitude,
                          );

                          final snackBar = SnackBar(
                            content: Text('Distance= $distance KM'),
                            action: SnackBarAction(
                              label: 'ok',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
