import 'package:flutter/material.dart';
import 'package:live_order_apps/models/order.dart';

class DraggableOrderCard extends StatelessWidget {
  final Order order;

  const DraggableOrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Draggable<Order>(
      data: order,
      feedback: Material(
        child: Container(
       width: 300,
          child: orderCard(isDragging: true),
        ),
      ),

      childWhenDragging: Container(height: 0, margin: EdgeInsets.only(bottom: 16),
      
      child: orderCard(),
      ),

      child: orderCard(),
    );



}

Widget orderCard({bool isDragging = false})
{

  return Card(

    margin: EdgeInsets.only(bottom: 16),
    elevation: isDragging ? 8 : 2,
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text('Order #${order.id}', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),),
        Text(
                  "\$${order.totalAmount}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8,),
          Text(order.customerName, style: TextStyle(
            fontWeight: FontWeight.w500,
color: Colors.grey[700],
          ),),
          SizedBox(height: 8,),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
            
            
            // border: BorderRadius.circular(12)
            ),
             child: Column(
                children: order.items.map((item) => Padding(
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
                )).toList(),
              ),
          )
        ],
      ),
    ),
  );
}

}