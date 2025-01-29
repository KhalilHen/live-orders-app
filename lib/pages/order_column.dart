// lib/widgets/order_board/order_column.dart
import 'package:flutter/material.dart';
import 'package:live_order_apps/models/enum/order_enum.dart';
import 'package:live_order_apps/models/order.dart';
import 'package:live_order_apps/pages/drag_order_card.dart';
import 'package:live_order_apps/pages/order_status.dart';

class OrderColumn extends StatelessWidget {
  final OrderStatus status;
  // final dragAbleModeStatus status;
  final List<Order> orders;
  final DragTargetAcceptWithDetails<Order> onOrderDropped;

  const OrderColumn({
    Key? key,
    required this.status,
    required this.orders,
    required this.onOrderDropped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  Expanded(

    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],

        borderRadius: BorderRadius.circular(12),
      ),
      child: DragTarget<Order>(
        
          onAcceptWithDetails: onOrderDropped,
          builder: (context, candidateData, rejectedData) {
              return Column(

                mainAxisSize: MainAxisSize.min,

                children: [
columnHeader(),

Expanded(child: ListView.builder(
  
  padding: EdgeInsets.all(8),
  itemCount: orders.length,
  itemBuilder: (context, index) {


                      return DraggableOrderCard(order: orders[index]);

  } ))
                ],
              );
          }

         ),
    
    ),
  );


  }

Widget columnHeader() {

  return Container(

    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(color: Status.getStatusColor1(status).withAlpha(22),
    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
     Text(
            status.toString().split('.').last,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Status.getStatusColor1(status),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(

              color: Status.getStatusColor1(status).withAlpha(22),
              borderRadius: BorderRadius.circular(12),

            ),
            child: Text(
              orders.length.toString(),
              style: TextStyle(
                color: Status.getStatusColor1(status),
                fontWeight: FontWeight.bold,

              ),
            ),
          )
      ],
    ),
  );
}
}