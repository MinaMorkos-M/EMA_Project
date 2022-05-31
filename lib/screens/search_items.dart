import 'package:ema_project/screens/product_restaurants_results.dart';
import 'package:flutter/material.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({Key? key}) : super(key: key);

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  final _startSearchFieldController = TextEditingController();

  String? searchProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ).add(
              EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            child: TextField(
              controller: _startSearchFieldController,
              autofocus: false,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                hintText: 'Search product',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  searchProduct = value;
                }
              },
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
          ),
          ElevatedButton(
            child: Text("Search"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductRestaurantsResults(searchProduct),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
