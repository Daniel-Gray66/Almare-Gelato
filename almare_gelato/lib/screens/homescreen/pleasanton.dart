import 'package:flutter/material.dart';
import 'common.dart';

class Pleasanton extends StatelessWidget {
  const Pleasanton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [storefrontImage(context), hours()],
    );
  }

  Widget storefrontImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 16/9,  // Fixed typo: aspectRation -> aspectRatio
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35.0),
          child: Image.asset(
            'images/pleasanton.jpg',
            fit: BoxFit.cover,  // Moved fit to Image.asset
          ),
        ),
      ),
    );
  }

  Widget hours() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: [
            const Divider(),
            const Text(
              "Hours",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            Table(
              border: Common.border(),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Common.row("Mon", "Closed"),
                Common.row("T-Th", "1pm-8pm"),
                Common.row("Fri", "12pm-8pm"),
                Common.row("Sat", "12pm-9pm"),
                Common.row("Sun", "Closed"),
              ],
            ),
            const Divider(height: 60),
            const Text(
              "Phone",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const Text("925 425 7266", style: TextStyle(fontSize: 20)),
            const Divider(height: 60),
            const Text(
              "Partners",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const Text("UberEats", style: TextStyle(fontSize: 20)),
            const Text("Grubhub", style: TextStyle(fontSize: 20)),
            const Text("Doordash", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}