import 'package:flutter/material.dart';
import 'package:live_order_apps/models/enum/order_enum.dart';
import 'package:live_order_apps/models/order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Order> orders = [];

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
      // body: orders.isEmpty
      //     ? Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(
      //               Icons.store,
      //               size: 64,
      //               color: Colors.grey,
      //             ),
      //             SizedBox(
      //               height: 16,
      //             ),
      //             Text(
      //               'No orders yet',
      //               style: TextStyle(fontSize: 18, color: Colors.grey[600]),
      //             )
      //           ],
      //         ),
      //       )
      // :

      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #1",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // statusChip(OrderStatus.Pending),
                  // statusChip(OrderStatus.Accepted),
                  // statusChip(OrderStatus.Completed),
                  // statusChip(OrderStatus.Kitchen),
                  // statusChip(OrderStatus.Ready),
                  // statusChip(OrderStatus.Rejected),
                ],
              ),
            ),
          );
        },
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

  //Building custom widget for status to easy handle different states
  Widget statusChip(OrderStatus status) {
    Color chipColor;
    String statusText;

    switch (status) {
      case OrderStatus.Pending:
        chipColor = Colors.orange;
        statusText = "Pending";

        break;

      case OrderStatus.Accepted:
        chipColor = Colors.lightBlue;
        statusText = "Accepted";
        break;

      case OrderStatus.Rejected:
        chipColor = Colors.red;
        statusText = "Rejected";
        break;

      case OrderStatus.Kitchen:
        chipColor = Colors.blue;
        statusText = "Kitchen";
        break;

      case OrderStatus.Ready:
        chipColor = Colors.green;
        statusText = "Ready for pick-up";
        break;

      case OrderStatus.Completed:
        chipColor = Colors.deepOrange;
        statusText = "Completed";

      default:
        chipColor = Colors.grey;
        statusText = "Unknown";
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: chipColor.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
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
      actions: [
        //** I am not sure whether to use these colors. As they are negative and positive action */
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Decline"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Accept"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            )
          ],
        ),

        // **Or using a more colors similair to the theme of the app. */
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // ElevatedButton(onPressed: () {}, child: Text("Cancel")),

        //     Expanded(
        //       child: TextButton(
        //         style: TextButton.styleFrom(
        //           padding: EdgeInsets.symmetric(vertical: 12),
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //         ),
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         },
        //         child: Text(
        //           "Decline",
        //           style: TextStyle(
        //             color: Colors.grey[700],
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(width: 8),
        //     ElevatedButton(
        //         onPressed: () {},
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.deepOrange,
        //           padding: EdgeInsets.symmetric(vertical: 12),
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //         ),
        //         child: Text(
        //           "Accept",
        //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //         ))
        //   ],
        // )
      ],
    );
  }
}
