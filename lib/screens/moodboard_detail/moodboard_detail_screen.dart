import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/repository/moodboard_database.dart';
import 'package:outfit_oracle/screens/detail/detail_screen.dart';
import 'package:outfit_oracle/screens/search/search_screen.dart';

import '../detail/cubit/detail_cubit.dart';

class MoodBoardDetailScreen extends StatefulWidget {
  final CategoryDB cat;

  MoodBoardDetailScreen({super.key, required this.cat});

  @override
  State<MoodBoardDetailScreen> createState() => _MoodBoardDetailScreenState();
}

class _MoodBoardDetailScreenState extends State<MoodBoardDetailScreen> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Oracle'),
        centerTitle: true,

      ),
      body: _items.isEmpty
          ? SearchScreen()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: InkResponse(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                            create: (context) => DetailCubit(),
                            child: DetailScreen(id: int.tryParse(_items[index].name) ?? 0),
                          );
                        }),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            _items[index].link ?? '',
                          ),
                          fit: BoxFit.fill,
                          onError: (error, stackTrace) =>
                              const Icon(Icons.error),
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
