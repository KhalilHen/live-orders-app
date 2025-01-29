import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:live_order_apps/widgets/statistik_card.dart';

class  StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Restaurant Stats",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(


        children: [
          Padding(padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              //Chart con
              Column(
children: [

  const Text("Restaurant growth", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 16,),
                 //This the graph container
              Row(
children: [
                   //TODO Work here late ron
    //* Container to simulate the graph space
                   Container(
                    height: 300,
                    width: 700,
                    color: Colors.red,
                   )
                  //   AspectRatio(
                  //   aspectRatio: 2.0,
                  //   child: LineChart(
                  //     LineChartData(
                  
                        
                  //     ),
                  //   ),
                  // ),

]

              )

              
]
            

              )

            ,
         
            ],
          ),
          )
,
          const Text("Today\s overview", style: TextStyle(
             fontSize: 20, fontWeight: FontWeight.bold,

          ),),

          const SizedBox(height: 16,),
          Row(

          children: [
            //tried importing the custom widget 
            // statistikCard()
            staticCard( "Today\s Orders ", "60", Icons.receipt_long, Colors.deepOrange),
              const SizedBox(width: 16,)
            , staticCard( "Today\s Revenue ", "€30", Icons.payment, Colors.green),
          ],  


             
          )
,
          Row(children: [
            staticCard( "Avg Order Value ", "€10", Icons.trending_up, Colors.blue),
              const SizedBox(width: 16,)
            , staticCard( "Active orders ", "10", Icons.pending_actions, Colors.orange),
          ],)
        ],
      ),
      
    );
  }

 Widget  growthGraph() {

  return Expanded(child: Container(

  ));
 }
  Widget staticCard(String title,  String value, IconData icon,  Color color) {

    return Expanded(
      
      child:  Container(
padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(

                    color: color.withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withAlpha(51),
                    width: 1,
                    
                    )

      ) , child: Column( crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        Container(
          padding: const EdgeInsets.all(8),

          decoration: BoxDecoration(
            color: color.withAlpha(51),
            borderRadius: BorderRadius.circular(8),

          ),
          child: Icon(icon, color: color, size: 24,),
        )

    // , const SizedBox(height: 16,)
    // , const SizedBox(height: 8,),
        ,  const SizedBox(height: 12,),
      Text(value, style: TextStyle(

        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color, 
      ),),
      const SizedBox(height: 4,),
      Text(title, style:  TextStyle(
        color: Colors.grey[600], fontSize: 14,

      ),)
      ],
      ),
      
      
      
      
      )
    );
  }


}