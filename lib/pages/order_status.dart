import 'package:/flutter/material.dart';
import 'package:live_order_apps/models/enum/order_enum.dart';

class Status {
//  *     Mabye keep this extra instance of the function. As in dragable you don't display 
//*  cancelled, maby in other view i am gonna keep the cancelled status display  /
  static Color getStatusColor(OrderStatus status) {

    switch (status) {
      case OrderStatus.Accepted:
        return Colors.lightBlue;

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
}