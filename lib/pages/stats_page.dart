import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:live_order_apps/pages/graph/line_chart.dart';
// import 'package:live_order_apps/widgets/statistik_card.dart';
//* This can be used for a single app. With restaurant + stats for  a on the go management app.

class StatsPage extends StatefulWidget {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Chart con
                  Column(children: [
                    const Text(
                      "Restaurant growth",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
//TODO Impprove this later so it can a correct size of graph container with displaying good the bullet dots
                    Container(
                      height: 150, //* This is too small but couldn't find better solution atm

                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]),
                      child: const LineChartGraph(),
                    ),
                    //This the graph container

                    //TODO Fix this
                    Row(children: [
                      //TODO Work here late ron
                      //* Container to simulate the graph space
                      //  Container(
                      //   height: 300,
                      //   width: 700,
                      //   color: Colors.red,
                      //  )
                      //   AspectRatio(
                      //   aspectRatio: 2.0,
                      //   child: LineChart(
                      //     LineChartData(

                      //     ),
                      //   ),
                      // ),
                    ])
                  ]),
                ],
              ),
            ),
            const Text(
              "Today\s overview",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                //tried importing the custom widget
                // statistikCard()
                staticCard("Today\s Orders ", "60", Icons.receipt_long, Colors.deepOrange),
                const SizedBox(
                  width: 16,
                ),
                staticCard("Today\s Revenue ", "€30", Icons.payment, Colors.green),
              ],
            ),
            Row(
              children: [
                staticCard("Avg Order Value ", "€10", Icons.trending_up, Colors.blue),
                const SizedBox(
                  width: 12,
                ),
                staticCard("Active orders ", "10", Icons.pending_actions, Colors.orange),
              ],
            ),

            // ,Padding(padding: const EdgeInsets.all(16),)
            SizedBox(
              height: 30,
            ),
            Text(
              "Total stats",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                staticCard("Total Orders", "700", Icons.receipt_long, Colors.deepOrange),
                const SizedBox(
                  width: 12,
                ),
                staticCard("Total Revenue", "€5000", Icons.payment, Colors.green),
              ],
            ),

            SizedBox(
              height: 30,
            ),

            Row(
              children: [
                staticCard("Avg Order value", "€60", Icons.trending_up, Colors.blue),
                const SizedBox(
                  width: 12,
                ),
                staticCard("Total Customers Served", "200", Icons.people, Colors.purple),
              ],
            ),

            SizedBox(
              height: 30,
            ),

            Row(
              children: [
                staticCard("Returning Customers", "50", Icons.person_outline, Colors.teal),
                const SizedBox(
                  width: 12,
                ),
                staticCard("Avg Order time ", "20m", Icons.schedule, Colors.deepOrange),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                staticCard("Best month", "Jan", Icons.calendar_month, Colors.blue),
                const SizedBox(
                  width: 12,
                ),
                staticCard("Worst month", "July", Icons.calendar_today, Colors.red),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Most Popular",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      //* For if i want to do a list of all items
                      //*Descending from most popular to least popular
                      TextButton(
                        onPressed: () {},
                        child: const Text("See all"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    separatorBuilder: (context, index) => const Divider(height: 24),
                    itemBuilder: (context, index) {
                      final items = [
                        {
                          'name': 'Pizza Margherita',
                          'price': '€5.00',
                          'description': 'Classic Italian pizza with tomatoes and mozzarella',
                          'icon': Icons.local_pizza,
                          'color': Colors.deepOrange,
                          'rating': 4.8,
                          'orders': '200+ orders'
                        },
                        {
                          'name': 'Classic Burger',
                          'price': '€4.00',
                          'description': 'Juicy beef patty with fresh vegetables',
                          'icon': Icons.lunch_dining,
                          'color': Colors.green,
                          'rating': 4.6,
                          'orders': '150+ orders'
                        },
                      ];

                      return Row(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: (items[index]['color'] as Color?)?.withAlpha(25),
                            ),
                            child: Icon(
                              items[index]['icon'] as IconData?,
                              color: items[index]['color'] as Color?,
                              size: 44,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index]['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  items[index]['description'] as String,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                    height: 1.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      items[index]['price'] as String,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: items[index]['color'] as Color?,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      Icons.star_rounded,
                                      size: 16,
                                      color: Colors.amber[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      items[index]['rating'].toString(),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      items[index]['orders'] as String,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;

            case 1:
              Navigator.pushNamed(context, 'restaurant');
              break;
            case 2:
              Navigator.pushNamed(context, '/account');
              break;

            case 3:
              Navigator.pushNamed(context, '/statics');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"), //* Dashboard/homepage

          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Restaurant"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),

          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: "Statics"),
        ],
      ),
    );
  }

  Widget growthGraph() {
    return Expanded(child: Container());
  }

  Widget staticCard(String title, String value, IconData icon, Color color) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withAlpha(51),
            width: 1,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(51),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          )

          // , const SizedBox(height: 16,)
          // , const SizedBox(height: 8,),
          ,
          const SizedBox(
            height: 12,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          )
        ],
      ),
    ));
  }
}
