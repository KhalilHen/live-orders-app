import 'package:flutter/material.dart';
import 'package:live_order_apps/onboarding/start_page.dart';
import 'package:live_order_apps/pages/account.dart';
import 'package:live_order_apps/pages/homepage.dart';
import 'package:live_order_apps/pages/login.dart';
import 'package:live_order_apps/pages/order_board.dart';
import 'package:live_order_apps/routes/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
      // home: Introduction(),
      home: HomePage(),
      // home: OrderBoard( 
      //   orders: [

          
      //   ],
      //   orderStatus: {},
      //   onOrderStatusChanged: (order, newStatus) {},
      // ),

      routes: {
        Routes.onBoarding: (context) => Introduction(),
        Routes.login: (context) => LoginPage(),
        Routes.home: (context) => HomePage(),
        // Routes.account: (context) => AccountPage(),
      },
    );
  }
}
