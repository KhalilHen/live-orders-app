import 'package:flutter/material.dart';
import 'package:live_order_apps/pages/homepage.dart';
import 'package:live_order_apps/pages/stats_page.dart';
import 'package:provider/provider.dart';

//TODO Adjust it so it fit's more a restaurant owner's account
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Account",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
               child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepOrange.withAlpha(25),
                            width: 4,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                              backgroundImage: const NetworkImage('data:image/jpeg;base64,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'),

                          backgroundColor: Colors.grey[100],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Restaurant',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Fastfood ',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Q
            Padding(padding: const EdgeInsets.all(02),
            child: Column(
              children: [
                Row(
                  children: [
                    staticCard("Today orders", "50", Icons.receipt_long, Colors.deepOrange),
                
                const SizedBox(width: 10,),
                staticCard("Total revenue",  "\$500", Icons.payments,
                Colors.green,
                // Colors.green.shade500
                // Colors.green.shade700 //I like this kind of dark green but i am 
                // Colors.green.shade600
                
                // Colors.green.shade900
                //  Colors.green.shade100
                
                ), 
                  ],
                ),
                //TODO Improve this later
            IconButton(onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const StatsPage()));

            }, icon: Icon(Icons.stacked_line_chart_sharp, color: Colors.deepOrange, size: 24), ),
              ],
            ),
            
            ),
//! These are not functional yet. But bit of how it can look in real case */
            settingSection(

              "Information", [
                settingsTile("Restaurant details", "Update your restaurant info", Icons.store,  ),

                settingsTile("Opening hours", "Adjust your opening hours/days", Icons.schedule),
                

                              ]
            ),
    settingSection("Menu managemnet", [
        // * Maby better to use the menu view instead of seperate button depending on which device the app is running.
      settingsTile("Menu items", "Manage your menu and sections", Icons.menu_book),

      settingsTile("Special promotions or offers", "Create here your discounts, promoties", Icons.local_offer),
    ])          ,

    settingSection("Account settings", [

      settingsTile("Account details", "Update your account details", Icons.person),
      settingsTile("Payment methods", "Add or remove payment methods", Icons.payment),
      settingsTile("Notifications", "Manage your notifications", Icons.notifications),
      settingsTile("Privacy & security", "Control your privacy settings", Icons.privacy_tip),
      settingsTile("Help & support", "Get help from our support team", Icons.help),
      settingsTile("Logout", "Sign out from your account", Icons.logout),
    ])
          

          
          ],
        ),
      ),
           bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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

  Widget settingSection(String title, List<Widget> tiles) {
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), 
    
    boxShadow:  [

      BoxShadow(
        color: Colors.black.withAlpha(13),
        blurRadius: 5, 
        offset: const Offset(0, 2),

      ),
    ],


    
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(16), child: Text(
          title, style: const TextStyle(fontSize: 18,  fontWeight: FontWeight.bold),
        ),),
        ...tiles, 
      ],
    ),
    );
  } 



   Widget settingsTile(
    String title,
    String subtitle,
    IconData icon, {
    bool showBadge = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.deepOrange.withAlpha(25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.deepOrange,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBadge)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'New',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
