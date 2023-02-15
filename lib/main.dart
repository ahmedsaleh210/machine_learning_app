import 'package:flutter/material.dart';
import 'package:ml_model/presentation/home_screen.dart';

void main() {
  runApp(const MLApp());
}

class MLApp extends StatelessWidget {
  const MLApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ML Model',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}