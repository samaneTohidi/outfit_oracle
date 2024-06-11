import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outfit_oracle/widgets/collection_list_widget.dart';

import '../models/collection_list_model.dart';
import '../repository/collection_list_request.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  CollectionListModel? collectionListModel;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadCollectionList();
  }

  void loadCollectionList() async {
    try {
      CollectionListModel data = await collectionListRequest();
      setState(() {
        collectionListModel = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionList = collectionListModel?.collections ?? [];
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : CollectionListWidget(collections: collectionList);
  }
}
