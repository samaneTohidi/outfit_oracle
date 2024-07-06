import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit_oracle/screens/detail/cubit/detail_cubit.dart';

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
  Widget build(BuildContext context) {
    context.read<DetailCubit>().fetchDetails(widget.id);
    return Scaffold(
        body: BlocConsumer<DetailCubit, DetailState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return state.when(
                initial: _buildInitial,
                loading: _buildLoading,
                loaded: _buildLoaded,
                error: _buildError);
          },
        )

    );
  }



  Widget _buildInitial() {
    return const Center(
      child: Text('Loading details...'),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoaded(DetailViewModel detailViewModel, String title, DescriptionDetails description) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(fontSize: 14.0),
          ),
          centerTitle: true,
        ),
        body: Stack(
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      child: Image.network(
                        detailViewModel.collection?.image ?? '',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                        loadingBuilder: (context, child,
                            loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${description.descEn}\n ${description
                          .bodyShapeEn}\n ${description.situationEn}',
                      style: const TextStyle(),
                    ),
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
                      showSaveCollectionModalBottomSheet(
                          context, detailViewModel);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
            ),
      );
  }

  Widget _buildError() {
    return const Center(
      child: Text('No details available'),
    );
  }
}

class DescriptionDetails {
  final String descEn;
  final String bodyShapeEn;
  final String situationEn;
  final String designEn;

  DescriptionDetails({
    required this.descEn,
    required this.bodyShapeEn,
    required this.situationEn,
    required this.designEn,
  });
}