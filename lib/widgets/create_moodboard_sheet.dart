
import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/moodboard_database.dart';

class CreateMoodboardSheet extends StatefulWidget {
  final List<CategoryDB> cats;
  final ValueChanged<List<CategoryDB>> onCatsUpdated;

  const CreateMoodboardSheet({super.key, required this.cats, required this.onCatsUpdated});

  @override
  State<CreateMoodboardSheet> createState() => _CreateMoodboardSheetState();
}

class _CreateMoodboardSheetState extends State<CreateMoodboardSheet> {
  late TextEditingController _moodboardNameController;

  final _db = MyDatabase.instance;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }
  void _saveData() async {
    final name = _moodboardNameController.text;
    final imagePath = _selectedImage?.path ;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a moodboard name.')),
      );
      return;
    }
    final newCategory = CategoriesCompanion(
      name: drift.Value(name),
      image: drift.Value(imagePath ?? ''),
    );

    await _db.addCategory(newCategory);
    final updatedCategories = await _db.getCategories();
    widget.onCatsUpdated(updatedCategories);
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double arrowDownHeight = screenSize.height * 0.12;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
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
                          'Outfit Oracle',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'THE FASHION SEARCH ENGINE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'CREATE MOODBOARD',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Enter a name to personalize your moodboard\nand save it by clicking on "create"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: TextField(
                    controller: _moodboardNameController,
                    decoration: const InputDecoration(
                      hintText: 'Moodboard name*',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    textAlign: TextAlign.center,
                    onSubmitted: (String value) async {},
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'SELECT IMAGE FROM GALLERY',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (_selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      _selectedImage!,
                      height: 100,
                      width: 100,
                    ),
                  ),
              ],
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
    );
  }

}