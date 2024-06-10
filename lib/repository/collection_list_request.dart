import 'dart:convert';
import 'package:dio/dio.dart';

import '../models/collection_list_model.dart';

Future<CollectionListModel> collectionListRequest() async {
  var headers = {
    'Content-Type': 'application/json',
  };

  var data = json.encode({
    "tags": [
      [101, 102, 103],
      [301, 302]
    ]
  });

  var dio = Dio();

  try {
    var response = await dio.post(
      'http://82.115.19.138:8282/api/v1/collection/list?limit=10&offset=2',
      options: Options(
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return CollectionListModel.fromJson(response.data);
    } else {
      print(response.statusMessage);
      throw Exception('Failed to load collection list');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load collection list');
  }
}
