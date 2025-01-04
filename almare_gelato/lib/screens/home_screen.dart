import 'package:almare_gelato/screens/homescreen/berkeley.dart';
import 'package:almare_gelato/screens/homescreen/pleasanton.dart';
import 'package:flutter/material.dart';
import '../widgets/customer_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                  bottom: const TabBar(tabs: [
                    Tab(
                      text: "Pleasanton",
                    ),
                    Tab(
                      text: "Berkeley",
                    ),
                  ]),
                  title: const Text("Gelato Shop")),
              drawer: const CustomDrawer(),
              body: const TabBarView(children: [Pleasanton(), Berkeley()]),
            )));
  }
}
