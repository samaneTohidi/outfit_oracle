
import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:outfit_oracle/widgets/sort_sheet.dart';

import '../models/detail_view_model.dart';
import '../repository/moodboard_database.dart';
import 'add_category_sheet.dart';

class SaveCollectionSheet extends StatefulWidget {
  DetailViewModel detail;
   SaveCollectionSheet({super.key, required this.detail});

  @override
  State<SaveCollectionSheet> createState() => _SaveCollectionSheetState();
}

class _SaveCollectionSheetState extends State<SaveCollectionSheet> {
  final _db = MyDatabase.instance;
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

  Future<void> _fetchCategories() async {
    final categories = await _db.getCategoriesSortedBy(_sortBy);
    setState(() {
      _categories = categories;
    });
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

    final itemExists = await _db.itemExists(itemId);
    if (!itemExists) {
      await _db.addCategoryWithItems(newCategory, [newItem]);
      print('Save $itemId.');

    } else {
      print('Item with id $itemId already exists.');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double arrowDownHeight = screenSize.height * 0.1;
    return
      Column(children: [
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
                  children: const [
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
                    itemBuilder: (context, index){
                      return GridTile(
                        child: InkResponse(
                          onTap: () {
                          showAddCategoryModalBottomSheet(context);
                          },
                          child: Stack(
                            children:[
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
                            ]

                          ),
                        ),
                      );
                    }
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
                  itemBuilder: (context, index){
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
                                  flex:9,
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
                                   ),                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),

      ],);
  }
}


void showSaveCollectionModalBottomSheet(BuildContext context, DetailViewModel detail) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return  FractionallySizedBox(
        heightFactor: 0.3,
        widthFactor: 1,
        child: SaveCollectionSheet(detail: detail),
      );
    },
  );
}
