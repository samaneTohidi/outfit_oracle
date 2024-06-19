
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../repository/moodboard_database.dart';

class Bookmark extends StatefulWidget {
  final List<Category> cats;
  final ValueChanged<List<Category>> onCatsUpdated;

  const Bookmark({super.key, required this.cats , required this.onCatsUpdated});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  late TextEditingController _moodboardNameController;
  late TextEditingController _imageController;

  final _db = MyDatabase.instance;


  @override
  void initState() {
    _moodboardNameController = TextEditingController();
    _imageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _moodboardNameController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveData() async {
    final name = _moodboardNameController.text;
    final image = _imageController.text;

    final newCategory = CategoriesCompanion(
      name: drift.Value(name),
      image: drift.Value('dgdffdgfd'),
    );

    await _db.addCategory(newCategory);
    final updatedCategories = await _db.getCategories();
    print('SAAAAAM updatedCategories${updatedCategories.first.name}');
    widget.onCatsUpdated(updatedCategories);
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double arrowDownHeight = screenSize.height * 0.05;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:  Container(
        child: Column(
          children: [
            Container(
              height: arrowDownHeight,
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down_outlined), onPressed: () {
                Navigator.pop(context);
              },
              ),
            ),

            Expanded(
              child:
              Column(
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: _moodboardNameController,
                        decoration: const InputDecoration(
                          hintText: 'name',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        textAlign: TextAlign.center,
                        onSubmitted: (String value) async {

                        },
                      ),
                    ],
                  ), // Add Lin

                ],
              ),
            ),
            FilledButton(
                onPressed: (){
                  _saveData();
                  Navigator.pop(context);
                }, child: const Text('Create'))
          ],
        ),

      ),

    );
  }

}
