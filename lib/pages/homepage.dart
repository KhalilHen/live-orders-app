import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:live_order_apps/models/enum/order_enum.dart';
import 'package:live_order_apps/models/menu.dart';
import 'package:live_order_apps/models/order.dart';
import 'package:live_order_apps/pages/order_board.dart';

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
  final AudioPlayer audioPlayer = AudioPlayer();

  bool isDialogShowing = false;

  bool isRestaurantOpen = true;
  bool isAutomaticOrders = true;
  bool newOrderSound = true;
  bool isDragAndDrop = false;
  @override
  void initState() {
    super.initState();

  audioPlayer.setSource(AssetSource('bell-sound.mp3'));

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
    if (!isRestaurantOpen) return;

    final Order newOrder = generateRandomOrder();
      //* Turned off until used again because of the sound */
      // playNotificationSound() ;


    if (isAutomaticOrders) {
      setState(() {
        orders.add(newOrder);
        orderStatuses[newOrder.id] = OrderStatus.Accepted;
      });
    } else {
      setState(() {
        isDialogShowing = true;
      });
      showDialog(context: context, builder: (context) => showOrderAlert(newOrder));
    }
  }

//TODO Find better sound when using real case scenario
Future<void> playNotificationSound() async {

  if (newOrderSound) {
    try { 
      
      await audioPlayer.play(AssetSource('bell-sound.mp3'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isRestaurantOpen ? Colors.green.withAlpha(22) : Colors.red.withAlpha(22),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isRestaurantOpen ? Colors.green : Colors.red,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(isRestaurantOpen ? Icons.store : Icons.store_outlined, size: 16, color: isRestaurantOpen ? Colors.green : Colors.red),
                              SizedBox(width: 4),
                              Text(
                                isRestaurantOpen ? "Open" : "Closed",
                                style: TextStyle(
                                  color: isRestaurantOpen ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isRestaurantOpen,
                          onChanged: (value) {
                            setState(() {
                              isRestaurantOpen = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              newOrderSound = !newOrderSound;
                            });
                          },
                          icon: Icon(
                            newOrderSound ? Icons.music_note : Icons.music_off,
                          ),
                          tooltip: newOrderSound ? "Turn off new order sound" : "Turn on new order sound",
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isAutomaticOrders = !isAutomaticOrders;
                            });
                          },
                          icon: Icon(
                            isAutomaticOrders ? Icons.notifications_active : Icons.notifications_off,
                            color: isAutomaticOrders ? Colors.deepOrange : Colors.grey,
                          ),
                          tooltip: 'Toggle Automatic Orders',
                        ),
                        //* I am not sure whether this will be used in a real life scenario */
                        IconButton(
                          onPressed: () {
                            setState(() {
                              orders.clear();
                              orderStatuses.clear();
                            });
                          },
                          icon: Icon(
                            Icons.cleaning_services,
                          ),
                          tooltip: "Clear all orders",
                        ),
                        // IconButton(onPressed: () {}, icon: Icon(Icons.reorder)),
                        // IconButton(onPressed: () {}, icon: Icon(Icons.open_with)),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isDragAndDrop = !isDragAndDrop;
                            });
                          },
                          icon: Icon(Icons.drag_indicator),
                          tooltip: "Switch to drag and drop mode",
                        ),

                        // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
                        // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu),
                          tooltip: "Switch to button  mode",
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isRestaurantOpen)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Restaurant is closed",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 13,
                ),
              ),
            ),
          Expanded(
            child:  OrderBoard(
              orders: orders,
              orderStatus: orderStatuses,
              onOrderStatusChanged: (order, newStatus) {
                setState(() {
                  orderStatuses[order.id] = newStatus;
                });
              },
              // isDragAndDrop: isDragAndDrop,

            ),
            // child: orders.isEmpty
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
                // // :
                //  ListView.builder(
                //     itemCount: orders.length,
                //     itemBuilder: (context, index) {
                //       final order = orders[index];
                //       final status = orderStatuses[order.id] ?? OrderStatus.Pending;
                //       final timeAgo = getTimeAgo(order.orderTime ?? DateTime.now());
                //       // final time
                //       return Card(
                //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //         elevation: 4,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(12),
                //             side: BorderSide(
                //               color: getStatusColor(status).withAlpha(22),
                //             )),
                //         child: Column(
                //           children: [
                //             Container(
                //               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                //               decoration: BoxDecoration(
                //                 color: getStatusColor(status).withAlpha(22),
                //                 borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(12),
                //                   topRight: Radius.circular(12),
                //                 ),
                //               ),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Row(
                //                     children: [
                //                       Icon(
                //                         Icons.receipt_long,
                //                         size: 20,
                //                         color: Colors.grey[70],
                //                       ),
                //                       SizedBox(
                //                         width: 8,
                //                       ),
                //                       Text(
                //                         "Order #${order.id}",
                //                         style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 16,
                //                         ),
                //                       ),
                //                       //* Maby a easy to acces button for support with specific order
                //                       // Then opens a dialog with field to put in what problem is
                //                       //Then sent the order id and the information to the support team.
                //                       IconButton(onPressed: null, icon: Icon(Icons.help))
                //                     ],
                //                   ),
                //                   statusChip(status),
                //                 ],
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(16),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Row(
                //                     children: [
                //                       CircleAvatar(
                //                         // backgroundColor: Colors.grey[700],
                //                         radius: 20,
                //                         child: Icon(
                //                           Icons.person_outline,
                //                           // color: Colors.grey[700],
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         width: 12,
                //                       ),
                //                       Column(
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                         children: [
                //                           Text(
                //                             order.customerName,
                //                             style: TextStyle(
                //                               fontWeight: FontWeight.w500,
                //                               fontSize: 16,
                //                             ),
                //                           ),
                //                           Text(
                //                             timeAgo,
                //                             style: TextStyle(
                //                               color: Colors.grey[600],
                //                               fontSize: 13,
                //                             ),
                //                           ),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                   SizedBox(height: 16),
                //                   Container(
                //                     padding: EdgeInsets.all(12),
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey[50],
                //                       borderRadius: BorderRadius.circular(8),
                //                       border: Border.all(color: Colors.grey[200]!),
                //                     ),
                //                     child: Column(
                //                       children: [
                //                         ...order.items
                //                             .map((item) => Padding(
                //                                   padding: const EdgeInsets.symmetric(vertical: 4),
                //                                   child: Row(
                //                                     children: [
                //                                       Container(
                //                                         padding: EdgeInsets.all(4),
                //                                         decoration: BoxDecoration(
                //                                           color: Colors.deepOrange.withAlpha(25),
                //                                           borderRadius: BorderRadius.circular(4),
                //                                         ),
                //                                         child: Text(
                //                                           "1x",
                //                                           style: TextStyle(
                //                                             color: Colors.deepOrange,
                //                                             fontWeight: FontWeight.bold,
                //                                           ),
                //                                         ),
                //                                       ),
                //                                       SizedBox(width: 8),
                //                                       Expanded(
                //                                         child: Text(
                //                                           item.name,
                //                                           style: TextStyle(
                //                                             fontSize: 14,
                //                                           ),
                //                                         ),
                //                                       ),
                //                                       Text(
                //                                         "\$${item.price}.00",
                //                                         style: TextStyle(
                //                                           fontWeight: FontWeight.w500,
                //                                         ),
                //                                       ),
                //                                     ],
                //                                   ),
                //                                 ))
                //                             .toList(),
                //                         Divider(
                //                           height: 24,
                //                         ),
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text(
                //                               "Total",
                //                               style: TextStyle(
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 16,
                //                               ),
                //                             ),
                //                             Text(
                //                               "\$${order.totalAmount}",
                //                               style: TextStyle(
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 16,
                //                                 color: Colors.deepOrange,
                //                               ),
                //                             ),
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                   //TODO Add function to after a order is completed for more then a 15 min it's fixed and can't change the position

                //                   if (status == OrderStatus.Accepted || status == OrderStatus.Kitchen || status == OrderStatus.Ready || status == OrderStatus.Completed)
                //                     Padding(
                //                       padding: const EdgeInsets.only(top: 8),
                //                       child: SizedBox(
                //                         width: double.infinity,
                //                         child: ElevatedButton.icon(
                //                           onPressed: () => showUpdateStatusDialog(order),
                //                           label: Text("Update status"),
                //                           icon: Icon(Icons.update),
                //                           style: ElevatedButton.styleFrom(
                //                               backgroundColor: Colors.deepOrange,
                //                               foregroundColor: Colors.white,
                //                               padding: EdgeInsets.symmetric(vertical: 12),
                //                               shape: RoundedRectangleBorder(
                //                                 borderRadius: BorderRadius.circular(8),
                //                               )),
                //                         ),
                //                       ),
                //                     )
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //   ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {

        playNotificationSound();
      },),
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

  String getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }

  Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
        return Colors.orange;
      case OrderStatus.Accepted:
        return Colors.lightBlue;
      case OrderStatus.Rejected:
        return Colors.red;
      case OrderStatus.Kitchen:
        return Colors.blue;
      case OrderStatus.Ready:
        return Colors.green;
      case OrderStatus.Completed:
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                ),
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