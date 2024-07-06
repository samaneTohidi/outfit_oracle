import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/detail_view_model.dart';
import '../../../repository/detail_view_request.dart';
import '../detail_screen.dart';

part 'detail_state.dart';

part 'detail_cubit.freezed.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(const DetailState.initial());

  Future<void> fetchDetails(int id) async {
    emit(const DetailState.loading());
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));
      final DetailViewModel detailViewModel = await detailViewRequest(id: id);
      final title = await _getTitle(detailViewModel);
      final description = await _getDescription(detailViewModel);
      emit(DetailState.loaded(detailViewModel,title,description ));
    } catch (error) {
      emit(const DetailState.error());
    }
  }

  Future<String> _getTitle(DetailViewModel detailViewModel) async {
    final jsonString = detailViewModel.collection?.title;
    Map<String, dynamic> decodedTitle = jsonDecode(jsonString ?? '');
    String enTitle = decodedTitle['en'];
    return enTitle;
  }

  Future<DescriptionDetails> _getDescription(
      DetailViewModel detailViewModel) async {
    final jsonString = detailViewModel.collection?.description;
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
}
