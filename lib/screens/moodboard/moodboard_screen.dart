import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outfit_oracle/widgets/create_moodboard_sheet.dart';
import 'package:outfit_oracle/widgets/sort_sheet.dart';

import '../../repository/moodboard_database.dart';
import '../moodboard_detail/moodboard_detail_screen.dart';

class MoodBoardScreen extends StatefulWidget {
  const MoodBoardScreen({super.key});

  @override
  State<MoodBoardScreen> createState() => _MoodBoardScreenState();
}

class _MoodBoardScreenState extends State<MoodBoardScreen> {
  List<CategoryDB> _categories = [];
  SortData? _sortBy = SortData.lastAdded;
  Map<int, int> _itemCounts = {};
  Map<int, List<Item>> _items = {};

  final _db = MyDatabase.instance;

  void _updateCategories(List<CategoryDB> newCategories) {
    setState(() {
      _categories = newCategories;
    });
  }

  @override
  void initState() {
    _fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    final categories = await _db.getCategoriesSortedBy(_sortBy!);
    final itemCounts = <int, int>{};
    final items = <int, List<Item>>{};

    for (var category in categories) {
      itemCounts[category.id] = await _db.getItemCountByCategoryId(category.id);
      items[category.id] = await _db.getItemsByCategoryId(category.id);
    }

    setState(() {
      _categories = categories;
      _itemCounts = itemCounts;
      _items = items;
    });
  }

  void _handleSort(SortData? newSort) {
    setState(() {
      _sortBy = newSort;
    });
    _fetchCategories();
  }

  Future<void> _deleteCat(int catId) async {
    await MyDatabase.instance.deleteCategory(catId);
    await _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY MOODBOARD',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
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
                        setState(() {
                          showSortModalBottomSheet(context, _sortBy, _handleSort);
                        });
                      },
                    ),
                    Text(
                      _sortBy!.description ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final itemCount = _itemCounts[category.id] ?? 0;
                      final items = _items[category.id] ?? [];

                      final imageLink = category.image;
                      final imageFile = File(imageLink!);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Dismissible(
                          key: Key(_categories[index].id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            await _deleteCat(_categories[index].id);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MoodBoardDetailScreen(cat:_categories[index]);
                                }),
                              );
                            },
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
                                  child: Positioned(
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(4.0),
                                      child: Align(
                                        child: Column(
                                          children: [
                                            Text(
                                          _categories[index].name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${itemCount} looks',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showMoodboardModalBottomSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMoodboardModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: CreateMoodboardSheet(
            cats: _categories,
            onCatsUpdated: _updateCategories,
          ),
        );
      },
    );
  }
}
