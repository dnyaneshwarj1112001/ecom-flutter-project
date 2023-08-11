// import 'dart:convert';

// import 'package:ecom2/secondpage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class gd extends StatefulWidget {
//   const gd({super.key});

//   @override
//   State<gd> createState() => _gdState();
// }

// class _gdState extends State<gd> {
//   List categeories = [];
//   List products = [];
//   _getcategeories() async {
//     var responce =
//         await http.get(Uri.parse("https://api.escuelajs.co/api/v1/categories"));
//     categeories = jsonDecode(responce.body);
//     setState(() {
//       categeories;
//     });
//   }

//   _getProducts() async {
//     var responce =
//         await http.get(Uri.parse("https://fakestoreapi.com/products"));
//     products = jsonDecode(responce.body);
//     setState(() {
//       products;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getcategeories();
//     _getProducts();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const Drawer(),
//       appBar: AppBar(
//         title: const Text('Our Products'),
//         actions: const [
//           Icon(Icons.shopping_cart_outlined),
//           Icon(Icons.notifications),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               child: Container(
//                 decoration: const BoxDecoration(),
//                 child: Image.network(
//                     "https://www.shutterstock.com/image-vector/monsoon-sale-rainy-season-umbrella-600w-1449212117.jpg"),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: SizedBox(
//                 height: 60,
//                 child: Container(
//                   child: Expanded(
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: categeories
//                           .length, // dynamic lenth by using direct accessing opretor
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => postdata(
//                                       id: categeories[index]["id"],
//                                       catagirydeteils: categeories[index]["name"],

//                                     ),
//                                   ));
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.green[600],
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       bottom: 10, left: 15, right: 15, top: 10),
//                                   child: Text(
//                                     categeories[index]['name'],
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.8,
//                   crossAxisSpacing: 10,
//                 ),
//                 itemCount: products.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.black)),
//                       child: Expanded(
//                           child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.network(
//                               products[index]["image"],
//                               height: 100,
//                             ),
//                           ),
//                           Text(
//                             products[index]["title"],
//                             style: const TextStyle(
//                                 overflow: TextOverflow.ellipsis,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             products[index]["price"].toString(),
//                             style: const TextStyle(
//                                 overflow: TextOverflow.ellipsis,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           ElevatedButton(
//                               onPressed: () {},
//                               child: const Text("Add To Card"))
//                         ],
//                       )));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data = [];

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  _getdata() async {
    var response = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian"));
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (jsonData.containsKey("meals")) {
      setState(() {
        data = jsonData["meals"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("app page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var meal = data[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200,
              width: 375,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Beef aitchbone ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Text("price"),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          child: Text(
                            "999.40 RS",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Buy Now"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 350,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          meal["strMealThumb"],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
