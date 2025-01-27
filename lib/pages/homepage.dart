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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //TODO add later
              Text("Close the restaurant:"),
              Padding(padding: const EdgeInsets.all(6)),
              Switch(
                  value: false,
                  onChanged: (bool newValue) {
                    setState(() {});
                  })
            ],
          ),
          Center(
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/homepage');
              break;

            case 1:
              Navigator.pushNamed(context, 'restaurant');
              break;
            case 2:
              Navigator.pushNamed(context, '/account');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"), //* Dashboard/homepage

          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Restaurant"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  AlertDialog showOrderAlert() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(Icons.priority_high, color: Colors.red),
          // SizedBox(width: 3),
          SizedBox(
            width: 3,
          ),
          Text("New Order!"),
          // Text("Incoming Order!"),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order #1",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Customer: John "),
          SizedBox(
            height: 5,
          ),
          Text("items")

          //Here late map
          ,
          SizedBox(
            height: 10,
          ),
          Text(
            "Total: €5",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
