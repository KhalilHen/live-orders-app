import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:line_icons/line_icons.dart';

PageViewModel startPage() {
  return PageViewModel(
    title: "Welcome to FoodPick",
    body: "Your favorite restaurants, just a tap away. Order delicious meals from the best local spots.",
    image: Icon(
      Icons.restaurant,
      size: 150.0,
      color: Colors.deepOrange[400],
    ),
    decoration: PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.grey[700],
      ),
      pageColor: Colors.white,
    ),
  );
}
