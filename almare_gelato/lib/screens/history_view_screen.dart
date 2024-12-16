import 'package:flutter/material.dart';
import 'home_screen.dart';

class HistoryViewScreen extends StatelessWidget {
  const HistoryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            " ALmare Gelato was founded by Alberto Malvestio In 2008.\n\n"
            "Alberto moved from the city of Treviso in northern Italy and "
            "brought with him the Italian gelato tradition of his great uncle "
            "Dino Del favaro, a true gelato legend in Reggio Emilia.\n\n"
            "Dino taught Alberto how to carefully prepare the bases mixing "
            "Milk, cream and sugars, how to let them simmer and cook together "
            "to give gelato the right texture and creaminess once frozen. He "
            "Also explained how cutting corners is just not an option when "
            "preparing fresh food.\n\n"
            "Alberto was able to use his passion for gelato to create "
            "Almare gelato that is both delicious and true to its roots.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
