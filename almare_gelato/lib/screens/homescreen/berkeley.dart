import 'package:flutter/material.dart';
import 'common.dart';

class Berkeley extends StatelessWidget {
  const Berkeley({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [storefrontImage(), hours()],
    );
  }

  Widget storefrontImage() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35.0),
          child: Align(
            alignment: const Alignment(-0.5, -0.2),
            widthFactor: 1,
            heightFactor: 0.82,
            child: Image.asset('images/Berkeley.jpg'),
          ),
        ),
      ),
    );
  }

  Widget hours() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(children: [
            const Divider(),
            const Text("Hours",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            Table(
              border: Common.border(),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth()
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Common.row("Everyday", "12pm-10pm"),
              ],
            ),
            const Divider(
              height: 60,
            ),
            const Text("Phone",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            const Text("510 649 1888", style: TextStyle(fontSize: 20)),
            const Divider(
              height: 60,
            ),
            const Text("Partners",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            const Text("UberEats", style: TextStyle(fontSize: 20)),
            const Text("Grubhub", style: TextStyle(fontSize: 20)),
            const Text("Doordash", style: TextStyle(fontSize: 20)),
          ]),
        ));
  }
}
