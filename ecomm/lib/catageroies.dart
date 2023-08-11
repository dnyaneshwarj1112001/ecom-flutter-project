import 'dart:convert';

import 'package:ecomm/sell.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleCategeories extends StatefulWidget {
  const SingleCategeories({super.key, required this.id});
  final int id;

  @override
  State<SingleCategeories> createState() => _SingleCategeoriesState();
}

class _SingleCategeoriesState extends State<SingleCategeories> {
  List sbCategories = [];
  List subData = [];
  bool isLoading = true; // Flag to control whether data is loading or not

  _getGeneralData() async {
    var productDataResponse = await http.get(
      Uri.parse("https://vsmart.ajspire.com/api/subcategories/${widget.id}"),
    );
    sbCategories = jsonDecode(productDataResponse.body)["subcategories"];
    setState(() {
      sbCategories;
      isLoading = false; // Set the flag to false when data fetching is complete
    });
  }

  productData() async {
    var responseData =
        await http.get(Uri.parse("https://vsmart.ajspire.com/api/products"));
    subData = jsonDecode(responseData.body)["products"]["data"];

    setState(() {
      isLoading = false; // Set the flag to false when data fetching is complete
    });
  }

  @override
  void initState() {
    super.initState();
    _getGeneralData();
    productData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sbCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Card(
                      margin: const EdgeInsets.only(left: 10),
                      color: Colors.deepPurple,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Text(
                              sbCategories[index]["subcategory_name"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  isLoading // Display the CircularProgressIndicator conditionally
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: subData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      // Pass the image here
                                      Image.network(
                                        subData[index]["product_image"],
                                        height: 100,
                                      ),
                                      Container(
                                        child: Text(
                                          subData[index]["english_name"],
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      Text(
                                        subData[index]["sale_price"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => sell()),
                                          );
                                        },
                                        child: const Text("Add To Cart"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
