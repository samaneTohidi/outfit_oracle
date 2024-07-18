
import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:outfit_oracle/screens/detail/cubit/detail_cubit.dart';
import 'package:outfit_oracle/widgets/sort_sheet.dart';

import '../models/detail_view_model.dart';
import '../repository/moodboard_database.dart';
import 'create_moodboard_sheet.dart';

class SaveCollectionSheet extends StatefulWidget {
  DetailViewModel detail;
  final DetailCubit cubit;
   SaveCollectionSheet({super.key, required this.detail, required this.cubit});

  @override
  State<SaveCollectionSheet> createState() => _SaveCollectionSheetState();
}

class _SaveCollectionSheetState extends State<SaveCollectionSheet> {
  List<CategoryDB> _categories = [];
  final SortData _sortBy = SortData.lastAdded;
  late CategoryDB _category;

  @override
  void initState() {
    _fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateCategories(List<CategoryDB> updatedCategories) {
    setState(() {
      _categories = updatedCategories;
    });
  }

  Future<void> _fetchCategories() async {
    final categories = await widget.cubit.getCategoriesSortedBy(_sortBy);
    _updateCategories(categories);
  }

  void _saveItem() async {
    final itemId = widget.detail.collection?.id.toString();
    final itemLink = widget.detail.collection?.image;
    final cat = _category.name;

    if (itemId == null) return;

    final newCategory = CategoriesCompanion(
      name: drift.Value(cat),
    );

    final newItem = ItemsCompanion(
      name: drift.Value(itemId),
      link: drift.Value(itemLink),
      categoryId: const drift.Value(0),
    );

    final itemExists = await widget.cubit.itemExists(itemId);
    if (!itemExists) {
      await widget.cubit.addCategoryWithItems(newCategory, [newItem]);
    } else {
      print('Item with id $itemId already exists.');
    }
  }

  void showMoodboardModalBottomSheet(BuildContext context, List<CategoryDB> categories, Function(List<CategoryDB>) onCategoriesUpdated) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: CreateMoodboardSheet(
            cats: categories,
            onSavePressed: (newCategory) async {
              await widget.cubit.addCategory(newCategory);
              final updatedCategories = await widget.cubit.getCategoriesSortedBy(_sortBy);
              onCategoriesUpdated(updatedCategories);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double arrowDownHeight = screenSize.height * 0.1;
    return Column(
      children: [
        Container(
          height: arrowDownHeight,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SAVE TO',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 4 / 5,
                  ),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: InkResponse(
                        onTap: () {
                          showMoodboardModalBottomSheet(
                            context,
                            _categories ?? [],
                            _updateCategories,
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                              ),
                            ),
                            const Center(
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 5,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 3.0,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final imageLink = category.image;
                    final imageFile = File(imageLink!);
                    return GridTile(
                      child: InkResponse(
                        onTap: () {
                          setState(() {
                            _category = _categories[index];
                          });
                          _saveItem();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Flexible(
                                flex: 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.grey, width: 2),
                                    image: DecorationImage(
                                      image: FileImage(imageFile),
                                      fit: BoxFit.cover,
                                      onError: (error, stackTrace) => const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  _categories[index].name.length > 10
                                      ? _categories[index].name.substring(0, 10) + '...'
                                      : _categories[index].name,
                                  overflow: TextOverflow.ellipsis,
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
        ),
      ],
    );
  }
}
void showSaveCollectionModalBottomSheet(
    BuildContext context, DetailViewModel detail, DetailCubit cubit) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.3,
        widthFactor: 1,
        child: SaveCollectionSheet(detail: detail, cubit: cubit),
      );
    },
  );
}