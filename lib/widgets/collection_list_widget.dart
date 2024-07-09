import 'package:flutter/material.dart';
import '../models/collection_list_model.dart';
import '../widgets/collection_item_widget.dart';

class CollectionListWidget extends StatelessWidget {
  final List<Collections> collections;
  final VoidCallback onLoadMoreCallback;

  const CollectionListWidget({
    Key? key,
    required this.collections,
    required this.onLoadMoreCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          print('SAM Reached the end of the list');
          onLoadMoreCallback();
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          return CollectionItemWidget(
            imageUrl: item.image!,
            label: item.title!,
            id: item.id!,
          );
        },
      ),
    );
  }
}
