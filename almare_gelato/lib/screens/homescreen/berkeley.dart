import 'package:flutter/material.dart';

class Berkeley extends StatelessWidget {
  const Berkeley({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [storefrontImage()],
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
}
