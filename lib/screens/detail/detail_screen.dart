import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/screens/detail/cubit/detail_cubit.dart';

import '../../models/description_model.dart';
import '../../models/detail_view_model.dart';
import '../../widgets/save_collection_sheet.dart';


class DetailScreen extends StatefulWidget {
  final int id;

  DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailCubit>().fetchDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailCubit, DetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.when(
          initial: () => _buildUI(),
          loading: () => _buildUI(),
          loaded: (detailViewModel, description, title) {
            return _buildUI(detailViewModel: detailViewModel, description: description, title: title);
          },
          error: () => const Center(child: Text('Error loading details')),
        );
      },
    );
  }

  Widget _buildUI({DetailViewModel? detailViewModel, DescriptionModel? description, String? title}) {
    return Scaffold(
      appBar: AppBar(title: _buildTitle(title)),
      body: _buildContent(detailViewModel, description),
    );
  }

  Widget _buildContent(DetailViewModel? detailViewModel, DescriptionModel? description) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: _buildImage(detailViewModel),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildDescription(description),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (detailViewModel != null) {
                      showSaveCollectionModalBottomSheet(context, detailViewModel);
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(DetailViewModel? detailViewModel) {
    if (detailViewModel != null) {
      return Image.network(
        detailViewModel.collection!.image!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      );
    } else {
      return Container(
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator()),
      );
    }
  }

  Widget _buildDescription(DescriptionModel? description) {
    if (description != null) {
      return Text(
        '${description.descEn}\n${description.bodyShapeEn}\n${description.situationEn}',
        style: const TextStyle(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildTitle(String? title) {
    return Text(title ?? 'Outfit Oracle');
  }
}
