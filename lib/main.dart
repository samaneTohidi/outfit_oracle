import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/screens/collection/collection_screen.dart';
import 'package:outfit_oracle/screens/collection/cubit/collection_cubit.dart';
import 'package:outfit_oracle/screens/moodboard/cubit/moodboard_cubit.dart';
import 'package:outfit_oracle/screens/moodboard/moodboard_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CollectionCubit()),
        BlocProvider(create: (_) => MoodboardCubit()),
      ],
      child: MaterialApp(
        title: 'Outfit Oracle',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodySmall: TextStyle(fontSize: 12.0),
            bodyMedium: TextStyle(fontSize: 14.0),
            bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
            headlineMedium:TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
            headlineLarge: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const NavigationDemo(),
      ),
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