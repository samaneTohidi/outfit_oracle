import 'package:dio/dio.dart';

import '../models/detail_view_model.dart';

Future<DetailViewModel> detailViewRequest({required int id}) async {

  var headers = {
    'Content-Type': 'application/json',
  };

  var data = '''''';

  var dio = Dio();

  try {
    var response = await dio.get(
      'http://82.115.19.138:8282/api/v1/collection/view/$id',
      options: Options(
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return DetailViewModel.fromJson(response.data);

    } else {
      throw Exception('Error: ${response.statusCode} ${response.statusMessage}');

    }
  } catch (e) {
    throw Exception('Failed to load detail Error:$e');
  }
}