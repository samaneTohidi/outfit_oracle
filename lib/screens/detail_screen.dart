import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outfit_oracle/widgets/add_category_sheet.dart';

import '../models/detail_view_model.dart';
import '../repository/detail_view_request.dart';
import '../widgets/save_collection_sheet.dart';


class DetailScreen extends StatefulWidget {
  final int id;
   DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailViewModel? _detailViewModel;
  bool _isLoading = true;
  String? _errorMessage;
  String? _enTitle;
  DescriptionDetails? _decoration;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<String> _getTitle() async {
    final jsonString =  _detailViewModel?.collection?.title;
    Map<String, dynamic> decodedTitle = jsonDecode(jsonString?? '');
    String enTitle = decodedTitle['en'];
    return enTitle;
  }

  Future<DescriptionDetails> _getDesc() async {
    final jsonString = _detailViewModel?.collection?.description;
    if (jsonString != null && jsonString.isNotEmpty) {
      Map<String, dynamic> decodedJson = jsonDecode(jsonString);

      String descEn = decodedJson['desc']['en'];
      String bodyShapeEn = decodedJson['body_shape']['en'];
      String situationEn = decodedJson['situation']['en'];
      String designEn = decodedJson['design']['en'];

      return DescriptionDetails(
        descEn: descEn,
        bodyShapeEn: bodyShapeEn,
        situationEn: situationEn,
        designEn: designEn,
      );
    } else {
      return DescriptionDetails(
        descEn: '',
        bodyShapeEn: '',
        situationEn: '',
        designEn: '',
      );
    }
  }


  Future<void> _fetchDetails() async {
    try {
      DetailViewModel detailViewModel = await detailViewRequest(id: widget.id);
      setState(() {
        _detailViewModel = detailViewModel;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
    _enTitle = await _getTitle();
    _decoration = await _getDesc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _enTitle?? '',
          style: const TextStyle(fontSize: 14.0),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text('Error: $_errorMessage'))
          : _detailViewModel != null
          ? Stack(
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
                      child: Image.network(
                        _detailViewModel?.collection?.image ?? '',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                        loadingBuilder: (context, child, loadingProgress) {
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
                      '${_decoration?.descEn}\n ${_decoration?.bodyShapeEn}\n ${_decoration?.situationEn}',
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
                      showSaveCollectionModalBottomSheet(context,_detailViewModel!);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : const Center(child: Text('No details available')),
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