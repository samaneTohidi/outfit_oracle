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
  bool isLoading = true;
  String? errorMessage;
  List<Collections> collections = [];
  bool isLoadingMore = false;
  int limit = 10;
  int offset = 0;

  @override
  void initState() {
    super.initState();
    loadCollectionList();
  }

  void loadCollectionList() async {
    setState(() {
      isLoading = true;
    });
    try {
      CollectionListModel data =
          await collectionListRequest(limit: limit, offset: offset);
      setState(() {
        collections.addAll(data.collections ?? []);
        isLoading = false;
        isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }

  void loadMore() {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
        offset += limit;
      });
      loadCollectionList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading && collections.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !isLoadingMore) {
                loadMore();
              }
              return false;
            },
            child: Column(
              children: [
                Expanded(child: CollectionListWidget(collections: collections)),
                if (isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          );
    // : CollectionListWidget(collections: collectionList);
  }
}
