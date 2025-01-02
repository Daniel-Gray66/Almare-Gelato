import 'package:flutter/material.dart';
import '../widgets/customer_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelato Shop'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Center(
                child: Text(
                  'ENJOY OUR GELATO, WE ARE OPEN!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              // const SizedBox(height: 20),
              // Images Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: ClipRRect(
                            child: Container(
                              child: Align(
                                alignment: Alignment(-0.5, -0.2),
                                widthFactor: 1,
                                heightFactor: 0.82,
                                child: Image.asset('images/Berkeley.jpg'),
                              ),
                            ),
                          ),
                        ),
                        // Image.asset('images/Berkeley.jpg'),
                        const SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        const Text(
                          'BERKELEY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: ClipRRect(
                            child: Container(
                              child: Align(
                                alignment: Alignment(-0.5, -0.2),
                                widthFactor: 1,
                                heightFactor: 1,
                                child: Image.asset('images/pleasanton.jpg'),
                              ),
                            ),
                          ),
                        ),
                        //Image.asset('images/pleasanton.jpg'),
                        const SizedBox(height: 10),
                        const Text(
                          'PLEASANTON',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Berkeley Description
              const Text(
                'BERKELEY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We are conveniently located on Bart Plaza, come enjoy a cup of authentic Italian gelato freshly made on site!!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'We are open every day from 12pm to 10pm.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'You can order directly at the store, pay on the phone with any card and pick up at the door! 510 649 1888',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Alternatively you can order via our online partners: UberEats, Grubhub or Doordash.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Pleasanton Description
              const Text(
                'PLEASANTON',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Come enjoy a cup of gelato on our sunny patio in beautiful Downtown Pleasanton!! Fresh, creamy gelato is waiting for you!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'We are open Tuesday to Thursday from 1pm to 8pm. Friday and Saturday 12pm to 9pm. We are closed on Mondays.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'You can order directly at the store, pay on the phone with any card and pick up at the door! 925 425 7266',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Alternatively you can order via our online partners: UberEats, Doordash.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
