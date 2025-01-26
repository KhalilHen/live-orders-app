import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel endingPage() {
  return PageViewModel(
    title: "Ready to grow your business?",
    body: "Join us now and reach more local customers.",
    image: Image.network(
      "https://media.istockphoto.com/id/1353684358/vector/a-fast-food-restaurant-female-caucasian-worker-behind-the-register-counter-serving-an-order.jpg?s=612x612&w=0&k=20&c=QwnjuIx2nf0CGwTtRW34zYnU4ZtdETjWOVphUn0GU6c=",
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
