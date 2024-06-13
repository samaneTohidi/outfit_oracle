import 'package:flutter/material.dart';
import 'package:outfit_oracle/screens/collection_screen.dart';
import 'package:outfit_oracle/screens/detail_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outfit Oracle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Outfit Oracle'),
          centerTitle: true,

        ),
          body: const CollectionScreen()),
    );
  }
}
