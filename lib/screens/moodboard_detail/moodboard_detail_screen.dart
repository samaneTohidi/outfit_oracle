import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/repository/moodboard_database.dart';
import 'package:outfit_oracle/screens/detail/detail_screen.dart';
import 'package:outfit_oracle/screens/moodboard/cubit/moodboard_cubit.dart';
import 'package:outfit_oracle/screens/moodboard_detail/cubit/moodboard_detail_cubit.dart';
import 'package:outfit_oracle/screens/search/search_screen.dart';

import '../detail/cubit/detail_cubit.dart';

class MoodBoardDetailScreen extends StatefulWidget {
  final CategoryDB cat;

  MoodBoardDetailScreen({super.key, required this.cat});

  @override
  State<MoodBoardDetailScreen> createState() => _MoodBoardDetailScreenState();
}

class _MoodBoardDetailScreenState extends State<MoodBoardDetailScreen> {


  @override
  void initState() {
    super.initState();
    context.read<MoodboardDetailCubit>().fetchItems(widget.cat.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoodboardDetailCubit, MoodboardDetailState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return state.when(
            initial: () => _buildUi(),
            loading: () => _buildUi(),
            loaded: (items) => _buildUi(items: items),
            error: () => const Center(child: Text('Error loading moodboard detail')),);
      },
    );
  }

  Widget _buildUi({List<Item>? items}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Oracle'),
        centerTitle: true,
      ),
      body: _buildContent(items),
    );
  }

  Widget _buildContent(List<Item>? items) {
    if (items != null && items.isNotEmpty) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) => DetailCubit(),
                      child: DetailScreen(
                          id: int.tryParse(items[index].name) ?? 0),
                    );
                  }),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      items[index].link ?? '',
                    ),
                    fit: BoxFit.fill,
                    onError: (error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return const SearchScreen();
    }
  }
}
