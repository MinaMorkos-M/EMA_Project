import 'package:ema_project/screens/search_items.dart';
import 'package:ema_project/screens/view_restaurants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('restaurants App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text('View All restaurants/cafes'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewRestaurants(),
                    ),
                  );
                },
          ),
          ListTile(
            title: Text('Search'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchItems(),
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }
}
