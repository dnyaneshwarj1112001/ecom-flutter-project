import 'dart:convert';

import 'package:ecomm/catageroies.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  List categories = [];
  List products = [];
  getdataformapi() async {
    var responce =
        await http.get(Uri.parse('https://vsmart.ajspire.com/api/categories'));
    categories = jsonDecode(responce.body)["categories"];

    setState(() {
      categories;
    });
  }

  getproductdata() async {
    var productresponce =
        await http.get(Uri.parse("https://vsmart.ajspire.com/api/products"));
    products = jsonDecode(productresponce.body)['products']['data'];
    setState(() {
      products;
    });
  }

  @override
  void initState() {
    super.initState();
    getdataformapi();
    getproductdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Text(
            "Add To card",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Icon(Icons.shopping_cart),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://as1.ftcdn.net/v2/jpg/03/36/91/22/1000_F_336912226_DNJl09LuALTfKO7wa3oYLnJXLVrJ7P7A.jpg"),
                    fit: BoxFit
                        .cover, // Adjust this property to control how the image fits within the container.
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                // width: 500,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleCategeories(
                                      id: categories[index]["category_id"],
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 15, right: 15, top: 5),
                            child: Text(
                              categories[index]['category_name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                      child: Expanded(
                        child: Column(
                          children: [
                            Image.network(products[index]["product_image"],
                                height: 100 ,
                                width: 100,
                                ),
                            Text(
                              products[index]["english_name"],
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              products[index]['sale_price'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('Add To card'))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
