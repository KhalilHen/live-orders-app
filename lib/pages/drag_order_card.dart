import 'package:flutter/material.dart';
import 'package:live_order_apps/models/order.dart';

class DraggableOrderCard extends StatelessWidget {
  final Order order;
  

  const DraggableOrderCard({
    Key? key,
    required this.order, required  

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Draggable<Order>(
      data: order,
      feedback: Material(
        // elevation: 4,
      
        // borderRadius: BorderRadius.circular(8),

        
        child: Container(
       width: 300,
            // width: MediaQuery.of(context).size.width * 0.2,
            // padding: const EdgeInsets.all(16),
            // decoration: BoxDecoration(
              // color: Colors.white,
              // borderRadius: BorderRadius.circular(8)
            // ,
            
            // ),
            child: orderCard(isDragging: true),
          // child: orderCard(isDragging: true),
          // child: Text(order.id.toString(), style: TextStyle(
            // color: Colors.grey.shade400,
          // ),
          // ), 
        ),
      ),
      childWhenDragging: Container(height: 0, margin: EdgeInsets.only(bottom: 16),
      
      child: orderCard(),
      ),

      child: orderCard(),
    );
      // childWhenDragging: Container(
        
      //   margin: const EdgeInsets.symmetric(vertical: 4),

      //   padding: const EdgeInsets.all(16),
      //   decoration: BoxDecoration(
      //     color: Colors.grey.shade200,
      //     borderRadius: BorderRadius.circular(8),

      //   ),
      //  child: Text(order.id.toString(), style: TextStyle(
      //   color: Colors.grey.shade400,
        
      //  ),),
      //   // height: 0,
      //   //  margin: EdgeInsets.only(bottom: 16),
      
      // // child: orderCard(),
      // ),
      // child: Card(margin: const EdgeInsets.symmetric(vertical: 4),
      
      // child: Container(
      //   padding: const EdgeInsets.all(16),
      //   child: Text(
      //     order.id.toString(),
      //     style: TextStyle(
      //       // color: Colors.grey.shade400,
      //    fontWeight: FontWeight.bold
      //     ),

      //   ),
      // ),
    

      // child: orderCard(),
  



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