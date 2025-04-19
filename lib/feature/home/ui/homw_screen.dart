import 'package:flutter/material.dart';

class HomwScreen extends StatelessWidget {
  const HomwScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home'),
      ),  
    );
  }
}