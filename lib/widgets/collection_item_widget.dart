
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionItemWidget extends StatelessWidget {
  final String imageUrl;
  final String label;

  CollectionItemWidget({required this.imageUrl, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
