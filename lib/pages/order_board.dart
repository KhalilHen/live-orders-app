import 'package:flutter/material.dart';
import 'package:live_order_apps/models/enum/order_enum.dart';
import 'package:live_order_apps/models/order.dart';
import 'package:live_order_apps/pages/order_column.dart';

class OrderBoard extends StatelessWidget {

  final List<Order> orders;
  final Map<int, OrderStatus> orderStatus;
  final Function(Order  order, OrderStatus newStatus) onOrderStatusChanged;


  const OrderBoard
  ({

    Key? key,
 required    this.orders,
 required   this.orderStatus,
   required  this.onOrderStatusChanged
  })

      : super(key: key);


      List<Order> getOrderBystatus(OrderStatus status) {
        return orders.where((order) => orderStatus[order.id] == status).toList();
      }


      @override 
      Widget build(BuildContext context) {

        return
          kanBanBoard();
      }

      Widget kanBanBoard() {

         return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: OrderStatus.values
            .where((status) => status != OrderStatus.Rejected)
            .map((status) => OrderColumn(
                  status: status,
                  orders: getOrderBystatus(status),
                  onOrderDropped: (order) => onOrderStatusChanged(order as Order, status),
                ))
            .toList(),
      ),
    );
      }
}