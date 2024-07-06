
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outfit_oracle/screens/detail/detail_screen.dart';

class CollectionItemWidget extends StatelessWidget {
  final String imageUrl;
  final String label;
  final int id;

  CollectionItemWidget({required this.imageUrl, required this.label, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return DetailScreen(id:id);
              }));
            },
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
        ),
      ],
    );
  }
}
