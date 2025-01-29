// lib/widgets/order_board/order_column.dart
import 'package:flutter/material.dart';
import 'package:live_order_apps/models/enum/order_enum.dart';
import 'package:live_order_apps/models/order.dart';

class OrderColumn extends StatelessWidget {
  final OrderStatus status;
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
    
    ),
  );


  }


}