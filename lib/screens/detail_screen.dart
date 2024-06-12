import 'package:flutter/material.dart';

import '../models/detail_view_model.dart';
import '../repository/detail_view_request.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailViewModel? _detailViewModel;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      DetailViewModel detailViewModel = await detailViewRequest(id: 480);
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
  }

  @override
  Widget build(BuildContext context) {

    print('SAMANO1${_detailViewModel?.collection?.image}');
    print('SAMANO${_detailViewModel?.collection?.description}');

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          _detailViewModel?.collection?.title ?? 'Detail',
          style: const TextStyle(fontSize: 14.0),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : _detailViewModel != null
                  ? Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://i.pinimg.com/474x/ec/f5/e7/ecf5e7508c6a294f8ec38f8016493dca.jpg',
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
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                               Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_detailViewModel?.collection?.description ?? '',
                                  style: TextStyle(),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Add your share functionality here
                                    },
                                    icon: const Icon(Icons.share),
                                    label: const Text('Share'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Add your save functionality here
                                    },
                                    icon: const Icon(Icons.save),
                                    label: const Text('Save'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Center(child: Text('No details available')),
    );
  }
}
