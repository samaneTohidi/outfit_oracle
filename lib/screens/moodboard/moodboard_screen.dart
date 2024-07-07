import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/widgets/create_moodboard_sheet.dart';
import 'package:outfit_oracle/widgets/sort_sheet.dart';

import '../../repository/moodboard_database.dart';
import '../moodboard_detail/moodboard_detail_screen.dart';
import 'cubit/moodboard_cubit.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/widgets/create_moodboard_sheet.dart';
import 'package:outfit_oracle/widgets/sort_sheet.dart';
import '../../repository/moodboard_database.dart';
import '../moodboard_detail/moodboard_detail_screen.dart';
import 'cubit/moodboard_cubit.dart';

class MoodBoardScreen extends StatefulWidget {
  const MoodBoardScreen({super.key});

  @override
  State<MoodBoardScreen> createState() => _MoodBoardScreenState();
}

class _MoodBoardScreenState extends State<MoodBoardScreen> {
  final SortData _sortBy = SortData.lastAdded;

  @override
  void initState() {
    super.initState();
    context.read<MoodboardCubit>().fetchCategories(_sortBy);
  }

  void _handleSort(SortData? newSort) {
    context.read<MoodboardCubit>().fetchCategories(newSort!);
  }

  void _updateCategories(List<CategoryDB> updatedCategories) {
    context.read<MoodboardCubit>().updateCategories(updatedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoodboardCubit, MoodboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.when(
          initial: () => _buildUi(),
          loading: () => _buildUi(),
          loaded: (categories, itemCounts, items) {
            return _buildUi(categories: categories, itemCounts: itemCounts, items: items);
          },
          error: () => const Center(child: Text('Error loading moodboard')),
        );
      },
    );
  }

  Widget _buildUi({List<CategoryDB>? categories, Map<int, int>? itemCounts, Map<int, List<Item>>? items}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY MOODBOARD'),
        centerTitle: true,
      ),
      body: _buildContent(categories, itemCounts, items),
    );
  }

  Widget _buildContent(List<CategoryDB>? categories, Map<int, int>? itemCounts, Map<int, List<Item>>? items) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () {
                        context.read<MoodboardCubit>().showSortModalBottomSheet(context, _sortBy, _handleSort);
                      },
                    ),
                    Text(
                      _sortBy!.description ?? '',
                    ),
                  ],
                ),
                Expanded(
                  child: _buildList(categories, itemCounts, items),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  context.read<MoodboardCubit>().showMoodboardModalBottomSheet(
                    context,
                    categories ?? [],
                    _updateCategories,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<CategoryDB>? categories, Map<int, int>? itemCounts, Map<int, List<Item>>? items) {
    if (categories == null || itemCounts == null || items == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final itemCount = itemCounts[category.id] ?? 0;
        final itemsList = items[category.id] ?? [];
        return CategoryItem(
          category: category,
          itemCount: itemCount,
          items: itemsList,
          onDelete: () async {
            await context.read<MoodboardCubit>().deleteCategory(category.id);
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MoodBoardDetailScreen(cat: category)),
            );
          },
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryDB category;
  final int itemCount;
  final List<Item> items;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.category,
    required this.itemCount,
    required this.items,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageFile = File(category.image!);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Dismissible(
        key: Key(category.id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onDelete(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            alignment: const Alignment(0.9, 0.9),
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 1 / 1.5,
                      child: Container(
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: DecorationImage(
                            image: FileImage(imageFile),
                            fit: BoxFit.cover,
                            onError: (error, stackTrace) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 8 / 10,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, gridIndex) {
                        final imageLink = gridIndex < items.length ? items[gridIndex].link : null;
                        return GridTile(
                          child: Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              image: imageLink != null && imageLink.isNotEmpty
                                  ? DecorationImage(
                                image: NetworkImage(imageLink),
                                fit: BoxFit.cover,
                                onError: (error, stackTrace) => const Icon(Icons.error),
                              )
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70, bottom: 8),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    child: Column(
                      children: [
                        Text(category.name),
                        Text('$itemCount looks'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

