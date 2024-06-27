import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outfit_oracle/repository/moodboard_database.dart';
import 'package:outfit_oracle/screens/detail_screen.dart';


class CategoryItemsScreen extends StatefulWidget {
  final CategoryDB cat;
   CategoryItemsScreen({super.key, required this.cat});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final _db = MyDatabase.instance;
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }


  Future<void> _fetchItems() async {
    final items = await _db.getItemsByCategoryId(widget.cat.id);
    setState(() {
      _items = items;
      print('item ${items.first.link}');
    });
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
          itemCount: _items.length,
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
                      image:  NetworkImage(
                        _items[index].link ?? '',
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