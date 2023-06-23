import 'package:disease_prediction/symptoms_selection_activity.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disease Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SymptomsSelectionActivity(),
    );
  }
}