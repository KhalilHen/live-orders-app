import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:live_order_apps/models/enum/order_enum.dart';
import 'package:live_order_apps/models/menu.dart';
import 'package:live_order_apps/models/order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Order> orders = [];
  Map<int, OrderStatus> orderStatuses = {};
  Timer? timer;
  final Random random = Random();
  bool isDialogShowing = false;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      //So that the different orders will not overlap each other
      if (!isDialogShowing) {
        showNewOrderAlert();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Order generateRandomOrder() {
    final List<String> customerNames = [
      "John",
      "Max",
      "Khalil",
      "Sara",
      "Ali",
      "Lina",
      "Mona",
      "Lara",
      "Layla",
      "Laila",
    ];
    final List<MenuItem> menuItems = [
      MenuItem(id: 1, name: 'Burger', description: 'Classic beef burger', price: 12, sectionId: 1),
      MenuItem(id: 2, name: 'Fries', description: 'Crispy french fries', price: 5, sectionId: 1),
      MenuItem(id: 3, name: 'Coke', description: 'Ice cold coca-cola', price: 3, sectionId: 2),
      MenuItem(id: 4, name: 'Pizza', description: 'Margherita pizza', price: 15, sectionId: 1),
    ];

    List<MenuItem> orderItems = [];
    int numberOfItems = random.nextInt(3) + 1;
    for (int i = 0; i < numberOfItems; i++) {
      orderItems.add(menuItems[random.nextInt(menuItems.length)]);
    }
    num totalAmount = orderItems.fold(0, (sum, item) => sum + item.price);

    return Order(
      id: orders.length + 1,
      restaurantId: 1,
      totalAmount: totalAmount,
      customerName: customerNames[random.nextInt(customerNames.length)],
      items: orderItems,
      orderTime: DateTime.now(),
    );
  }

  void showNewOrderAlert() {
    setState(() {
      isDialogShowing = true;
    });
    final Order newOrder = generateRandomOrder();
    showDialog(context: context, builder: (context) => showOrderAlert(newOrder));
  }

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
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'No orders yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final status = orderStatuses[order.id] ?? OrderStatus.Pending;
                // final time
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
                          "Order #${order.id}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        statusChip(status),
                        // statusChip(OrderStatus.Accepted),
                        // statusChip(OrderStatus.Completed),
                        // statusChip(OrderStatus.Kitchen),
                        // statusChip(OrderStatus.Ready),
                        // statusChip(OrderStatus.Rejected),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text("Customer: ${order.customerName}"),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Items:  ${order.items.map((item) => item.name).join(', ')}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Total: \$${order.totalAmount}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        //TODO Add function to after a order is completed for more then a 15 min it's fixed and can't change the position

                        if (status == OrderStatus.Accepted || status == OrderStatus.Kitchen || status == OrderStatus.Ready || status == OrderStatus.Completed)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ElevatedButton(
                              onPressed: () => showUpdateStatusDialog(order),
                              child: Text("Update status"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(context: context, builder: (context) => showOrderAlert());
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.deepOrange,
      // ),
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

  showUpdateStatusDialog(Order order) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.update,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Update Order status",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        statusOption(
                          context,
                          order,
                          OrderStatus.Kitchen,
                          Icons.restaurant,
                          "In Kitchen",
                          "Order is being prepared",
                          orderStatuses[order.id] ?? OrderStatus.Pending,
                        ),
                        Divider(height: 1),
                        statusOption(
                          context,
                          order,
                          OrderStatus.Ready,
                          Icons.delivery_dining,
                          "Ready for Pickup",
                          "Order is ready to be picked up",
                          orderStatuses[order.id] ?? OrderStatus.Pending,
                        ),
                        Divider(height: 1),
                        statusOption(
                          context,
                          order,
                          OrderStatus.Completed,
                          Icons.check_circle,
                          "Completed",
                          "Order has picked-up",
                          orderStatuses[order.id] ?? OrderStatus.Pending,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ));
  }

  Widget statusOption(
    BuildContext context,
    Order order,
    OrderStatus status,
    IconData icon,
    String title,
    String subtitle,
    OrderStatus currentStatus,
  ) {
    final bool isCurrentStatus = currentStatus == status;
    return InkWell(
      onTap: () {
        setState(() {
          orderStatuses[order.id] = status;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isCurrentStatus ? Colors.deepOrange.withAlpha(21) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isCurrentStatus ? Colors.deepOrange.withOpacity(0.2) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: isCurrentStatus ? Colors.deepOrange : Colors.grey[600]),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isCurrentStatus ? FontWeight.bold : FontWeight.w500,
                      color: isCurrentStatus ? Colors.deepOrange : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (isCurrentStatus)
              Icon(
                Icons.check_circle,
                color: Colors.deepOrange,
                size: 20,
              )
          ],
        ),
      ),
    );
  }

  AlertDialog showOrderAlert(dynamic newOrder) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            // Icons.receipt_long,
            Icons.priority_high,
            // color: Colors.deepOrange,
            color: Colors.red,
          ),
          SizedBox(width: 8),
          Text(
            "New Order",
            style: TextStyle(
              // color: Colors.deepOrange,
              // color: Colors.black87,
              color: Colors.black,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person_outline,
                color: Colors.grey[600],
              ),
            ),
            title: Text(
              newOrder.customerName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text("Customer"),
          ),
          Divider(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Order Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              )),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...newOrder.items
                    .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "1× ${item.name}",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text("\$${item.price}.00"),
                            ],
                          ),
                        ))
                    .toList(),
                Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "\$${newOrder.totalAmount}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
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
                setState(() {
                  orders.add(newOrder);
                  orderStatuses[newOrder.id] = OrderStatus.Rejected;
                  isDialogShowing = false;
                });
                Navigator.pop(context);
              },
              child: Text("Decline"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  orders.add(newOrder);
                  orderStatuses[newOrder.id] = OrderStatus.Accepted;
                  isDialogShowing = false;
                });
                Navigator.pop(context);
              },
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
