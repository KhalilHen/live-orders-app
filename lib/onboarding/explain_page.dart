import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel explainPage() {
  return PageViewModel(
    title: "Quick & Easy  manage your orders",
    body: "Browse menus, customize your order, and track your order in real-time. It's that simple!",
    image: Image.asset(
      'explain.png',
      // "https://www.jotform.com/blog/wp-content/uploads/2020/07/food-order-management-01.png",

      // "https://www.jotform.com/blog/wp-content/uploads/2020/07/food-order-management-01.png",
      // "https://www.jotform.com/blog/wp-content/uploads/2020/07/food-order-management-01.png",
      // "https://www.jotform.com/blog/wp-content/uploads/2020/07/food-order-management-01.png", //* Doesn't work anymore?

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
