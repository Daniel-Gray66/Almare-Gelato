import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'Database.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await DatabaseHelper.instance.database; // This ensures the database is initialized
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gelato Shop App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
