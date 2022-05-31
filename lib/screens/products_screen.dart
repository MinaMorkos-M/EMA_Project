import 'package:ema_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Products extends StatefulWidget {
  final String id;
  Products(this.id);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Product>? products;

  getProducts() async {
    products = await getRestaurantsProducts();
    setState(() {});
  }

  Future<List<Product>> getRestaurantsProducts() async {
    var url = 'https://mymobile.conveyor.cloud/api/restaurants/${widget.id}';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['\$values'] as List;
    return jsonResults.map((place) => Product.fromJson(place)).toList();
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Products'),
      ),
      body: (products != null)
          ? ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Divider(),
                    ListTile(
                      title: Text(
                        products![index].name.toString(),
                      ),
                      subtitle: Text("Price: ${products![index].price}"),
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
