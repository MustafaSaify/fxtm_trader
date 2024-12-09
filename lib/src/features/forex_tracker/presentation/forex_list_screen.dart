import 'package:flutter/material.dart';

class ForexListScreen extends StatefulWidget {
  const ForexListScreen({super.key});

  @override
  State<ForexListScreen> createState() => _ForexListScreenState();
}

class _ForexListScreenState extends State<ForexListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Forex Tracker'),
      ),
      body: const Center(
          child: Text(
              'Price List')), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
