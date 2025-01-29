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
        LayoutBuilder(builder: (context, constraints) {
          bool useColumnLayout = constraints.maxWidth  <1100;
          return kanBanBoard(constraints, useColumnLayout);
        });
      }

      Widget kanBanBoard(BoxConstraints constraints, bool useColumnLayout) {


        final statusColumns = OrderStatus.values.where((status) => status != OrderStatus.Rejected).map((status)
        
        => OrderColumn(    status: status,
              orders: getOrderBystatus(status),
              onOrderDropped: (order) => onOrderStatusChanged(order as Order, status),

        
        
        )
        ).toList( );

           if (useColumnLayout) {
      // Column layout for iPad
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: statusColumns.map((column) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: double.infinity,

                //*Not sure about which height is best
                // height: 200
                height: 400,
                child: column,
              ),
            )).toList(),
          ),
        ),
      );
    }
    else {

        return Container(

          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: statusColumns.map((column) => Expanded(
                child: column,
            
            )).toList(),
          ),
        );
    }

        
    //      return Container(
    //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),

    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: OrderStatus.values
    //     //TODO Later change this
    //         .where((status) => status != OrderStatus.Rejected)
    //         .map((status) => Expanded(
    //           child: OrderColumn(
    //                 status: status,
    //                 orders: getOrderBystatus(status),
    //                 onOrderDropped: (order) => onOrderStatusChanged(order as Order, status),
    //               ),
    //         ))
    //         .toList(),
    //   ),
    // );
      }
}