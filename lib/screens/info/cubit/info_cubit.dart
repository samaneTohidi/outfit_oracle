import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:outfit_oracle/repository/detail_view_request.dart';
import 'package:outfit_oracle/screens/info/info_screen.dart';

import '../../../models/detail_view_model.dart';

part 'info_state.dart';
part 'info_cubit.freezed.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(const InfoState.initial());

  Future<void> getInfo() async {
    emit(const InfoState.loading());
    try{
      final DetailViewModel detailViewModel = await detailViewRequest(id: 430);
      emit(InfoState.loaded(detailViewModel));
    }catch(error){
      emit(const InfoState.error());
    }

  }
}
