import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Incoming Orders",
          //*Incoming Orders, or Orders not sure yet about the title.
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return showOrderAlert();
              },
            );
          },
          child: Text("Show dialog"),
        ),
      ),
    );
  }

  AlertDialog showOrderAlert() {
    return AlertDialog(
      title: Text("Incoming Order"),
      content: Text("New incomming order do you want to accept o cancel this order?"),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ElevatedButton(onPressed: null, child: Text("Cancel")), ElevatedButton(onPressed: null, child: Text("Accept"))],
        )
      ],
    );
  }
}
