import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: const Center(child: Text('No items yet! Add some.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DoNothingAction; //TODO: add an item here :)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
