import 'package:flutter/material.dart';

class PriceListScreen extends StatefulWidget {
  const PriceListScreen({super.key});

  @override
  State<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Forex Tracker'),
      ),
      body: const Center(
        child: Text('Price List')
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
