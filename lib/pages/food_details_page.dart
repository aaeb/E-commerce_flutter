import 'package:flutter/material.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({super.key});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 350,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/food1.png"),
                ),
              ),
            ))
      ]),
    );
  }
}
