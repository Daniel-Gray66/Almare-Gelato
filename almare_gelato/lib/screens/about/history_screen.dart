import 'package:flutter/material.dart';
import '../../widgets/navigation/customer_drawer.dart';
import '../../widgets/common/app_bar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'History'),
      drawer: const CustomDrawer(),
      body: Center(
        child: Text('History Screen'),
      ),
    );
  }
} 