import 'package:flutter/material.dart';

class Pleasanton extends StatelessWidget {
  const Pleasanton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [storefrontImage(), storeInfo()],
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
            child: Image.asset('images/pleasanton.jpg'),
          ),
        ),
      ),
    );
  }

  Widget storeInfo() {
    return SingleChildScrollView(
      child: Center(
        child: Row(
          children: [
            hours(),
          ],
        ),
      ),
    );
  }

  Widget hours() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(flex: 4),
        1: IntrinsicColumnWidth(),
        // 1: FlexColumnWidth(),
        // 2: FixedColumnWidth(60)
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: const [
        TableRow(children: [Text("Th-Th 1pm-8pm"), Text("Th-Th 1pm-8pm")]),
        TableRow(children: [Text("Th-Th 1pm-8pm"), Text("Th-Th 1pm-8pm")]),
        // TableRow(children: [Text("Th-Th 1pm-8pm")])
      ],
    );
  }
}
