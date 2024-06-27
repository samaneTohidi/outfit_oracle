import 'package:flutter/material.dart';
import 'package:outfit_oracle/screens/collection_screen.dart';
import 'package:outfit_oracle/screens/detail_screen.dart';
import 'package:outfit_oracle/screens/moodboard_screen.dart';


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

      home: const NavigationDemo(),
    );
  }
}

class NavigationDemo extends StatefulWidget {
  const NavigationDemo({super.key});

  @override
  State<NavigationDemo> createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.collections),
            icon: Icon(Icons.collections_outlined),
            label: 'Collections',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark_outlined),
            icon: Icon(Icons.bookmark_border_outlined),
            label: 'MoodBoards',
          ),

        ],
      ),
      body: <Widget>[
        const CollectionScreen(),
        const MoodBoardScreen(),
      ][currentPageIndex],
    );
  }
}