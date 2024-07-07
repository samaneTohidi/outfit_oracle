import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/description_model.dart';
import '../../../models/detail_view_model.dart';
import '../../../repository/detail_view_request.dart';

part 'detail_state.dart';

part 'detail_cubit.freezed.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(const DetailState.initial());

  Future<void> fetchDetails(int id) async {
    emit(const DetailState.loading());

    try {
      final DetailViewModel detailViewModel = await detailViewRequest(id: id);
      final description = await _getDescription(detailViewModel);
      final title = await _getTitle(detailViewModel);
      emit(DetailState.loaded(detailViewModel ,description, title));
    } catch (error) {
      emit(const DetailState.error());
    }
  }

  Future<String> _getTitle(DetailViewModel detailViewModel) async {
    final jsonString = detailViewModel.collection?.title;
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        Map<String, dynamic> decodedTitle = jsonDecode(jsonString);
        if (decodedTitle.containsKey('en')) {
          String enTitle = decodedTitle['en'];
          return enTitle;
        } else {
          throw Exception('Key "en" not found in JSON');
        }
      } catch (e) {
        throw Exception('Error decoding JSON: $e');
      }
    } else {
      throw Exception('Title is null or empty');
    }
  }

  Future<DescriptionModel> _getDescription(
      DetailViewModel detailViewModel) async {
    final jsonString = detailViewModel.collection?.description;
    if (jsonString != null && jsonString.isNotEmpty) {
      Map<String, dynamic> decodedJson = jsonDecode(jsonString);

      String descEn = decodedJson['desc']['en'];
      String bodyShapeEn = decodedJson['body_shape']['en'];
      String situationEn = decodedJson['situation']['en'];
      String designEn = decodedJson['design']['en'];

      return DescriptionModel(
        descEn: descEn,
        bodyShapeEn: bodyShapeEn,
        situationEn: situationEn,
        designEn: designEn,
      );
    } else {
      return DescriptionModel(
        descEn: '',
        bodyShapeEn: '',
        situationEn: '',
        designEn: '',
      );
    }
  }
}
