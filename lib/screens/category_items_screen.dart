import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outfit_oracle/repository/moodboard_database.dart';
import 'package:outfit_oracle/screens/detail_screen.dart';


class CategoryItemsScreen extends StatefulWidget {
    // final Category categories;
   CategoryItemsScreen({super.key});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
             'Detail',
            style: const TextStyle(fontSize: 14.0),
          ),
          centerTitle: true,
      ),
      body:
      GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: 9,
          itemBuilder: (context, index){
            return GridTile(
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const DetailScreen(id: 10);
                    }),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const NetworkImage(
                        'https://i.pinimg.com/474x/c6/62/26/c66226dc6b2bacc88095a4995f42d9ee.jpg',
                      ),
                      fit: BoxFit.fill,
                      onError: (error, stackTrace) => const Icon(Icons.error),

                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}