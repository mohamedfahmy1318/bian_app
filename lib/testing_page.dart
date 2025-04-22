import 'package:flutter/material.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Page'),
      ),
      body: const Center(
        child: Text('This is a testing page.'),
      ),
    );
  }
}
