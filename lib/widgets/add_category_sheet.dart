
import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../repository/moodboard_database.dart';

class AddCategorySheet extends StatefulWidget {
  const AddCategorySheet({super.key});

  @override
  State<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<AddCategorySheet> {
  late TextEditingController _moodboardNameController;

  final _db = MyDatabase.instance;

  @override
  void initState() {
    _moodboardNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _moodboardNameController.dispose();
    super.dispose();
  }

  void _saveData() async {
    final name = _moodboardNameController.text;
    final newCategory = CategoriesCompanion(
      name: drift.Value(name),
      image: drift.Value('dgdffdgfd'),
    );

    await _db.addCategory(newCategory);
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
                  children: const [
                    Text(
                      'CREATE MOODBOARD',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:24 , right: 24),
                child: TextField(
                  controller: _moodboardNameController,
                  decoration: const InputDecoration(
                    hintText: 'Moodboard name*',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  textAlign: TextAlign.center,
                  onSubmitted: (String value) async {},
                ),
              ),
              GestureDetector(
                onTap: () {
                  _saveData();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'CREATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}


void showAddCategoryModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const FractionallySizedBox(
        heightFactor: 0.3,
        widthFactor: 1,
        child: AddCategorySheet(),
      );
    },
  );
}
