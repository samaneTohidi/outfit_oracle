import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/widgets/collection_list_widget.dart';

import '../../models/collection_list_model.dart';
import '../../repository/collection_list_request.dart';
import 'cubit/collection_cubit.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionCubit>().loadCollections();
  }

  void _loadMoreCollections() {
    context.read<CollectionCubit>().loadCollections(loadMore: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Oracle'),
        centerTitle: true,
      ),
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (collections) => CollectionListWidget(
              collections: collections,
              onLoadMoreCallback: _loadMoreCollections,
            ),
            error: () => const Center(child: Text('Error: ')),
          );
        },
      ),
    );
  }
}
