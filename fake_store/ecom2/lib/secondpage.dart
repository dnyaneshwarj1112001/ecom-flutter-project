import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postdata extends StatefulWidget {
  const postdata({Key? key, required this.id, required this.catagirydeteils})
      : super(key: key);
  final int id;
  final String catagirydeteils;

  @override
  State<postdata> createState() => _postdataState();
}

class _postdataState extends State<postdata> {
  Map<String, dynamic> productData = {};

  _getfdata() async {
    var dataResponse = await http.get(Uri.parse(
        "https://fakestoreapi.com/products/${widget.id},${widget.catagirydeteils}"));

    setState(() {
      productData = jsonDecode(dataResponse.body);
    });
  }

  @override
  void initState() {
    super.initState();
    _getfdata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.catagirydeteils,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
