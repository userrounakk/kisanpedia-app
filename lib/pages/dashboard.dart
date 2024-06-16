import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("Hi")),
    );
  }
}
