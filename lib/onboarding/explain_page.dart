import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel explainPage() {
  return PageViewModel(
    title: "Effortlessly Manage Your Orders",
    body: "Easily browse menus, customize orders, and track them in real-time. Enhance your customer experience with our seamless order management system.",
    image: Image.network(
      "https://www.jotform.com/blog/wp-content/uploads/2020/07/food-order-management-01.png",
      height: 250.0,
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
