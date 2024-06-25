
import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:outfit_oracle/widgets/add_category_sheet.dart';

import '../repository/moodboard_database.dart';

class SaveCollectionSheet extends StatefulWidget {
  const SaveCollectionSheet({super.key});

  @override
  State<SaveCollectionSheet> createState() => _SaveCollectionSheetState();
}

class _SaveCollectionSheetState extends State<SaveCollectionSheet> {

  final _db = MyDatabase.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 4 / 4,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemCount: 20,
            itemBuilder: (context, index){
              if(index == 0){
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
              }else{
                return GridTile(
                  child: InkResponse(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) {
                      //     return const DetailScreen(id: 10);
                      //   }),
                      // );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const NetworkImage(
                            'https://i.pinimg.com/474x/c6/62/26/c66226dc6b2bacc88095a4995f42d9ee.jpg',
                          ),
                          fit: BoxFit.fill,
                          onError: (error, stackTrace) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                );
              }

            },
          ),
        ),

      ],);
  }
}


void showSaveCollectionModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const FractionallySizedBox(
        heightFactor: 0.3,
        widthFactor: 1,
        child: SaveCollectionSheet(),
      );
    },
  );
}
