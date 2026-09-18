import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const HomeScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Up Tracker'),
      ),
      body: Center(
        child: Text(
          'Welcome, ${user['name'] ?? user['email']}!',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}