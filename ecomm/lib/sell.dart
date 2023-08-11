import 'package:flutter/material.dart';

class sell extends StatefulWidget {
  const sell({super.key});

  @override
  State<sell> createState() => _sellState();
}

class _sellState extends State<sell> {
// get image form upi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Buy ...",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          height: 330,
          width: 330,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Image(
                  image: NetworkImage(
                      "https://as1.ftcdn.net/v2/jpg/03/36/91/22/1000_F_336912226_DNJl09LuALTfKO7wa3oYLnJXLVrJ7P7A.jpg"))),
        ),
      ),
    );
  }
}
