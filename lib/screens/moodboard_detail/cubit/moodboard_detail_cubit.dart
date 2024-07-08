import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../repository/moodboard_database.dart';

part 'moodboard_detail_state.dart';
part 'moodboard_detail_cubit.freezed.dart';

class MoodboardDetailCubit extends Cubit<MoodboardDetailState> {
  MoodboardDetailCubit() : super(const MoodboardDetailState.initial());

  final _db = MyDatabase.instance;


  Future<void> fetchItems(int id ) async {
    emit(const MoodboardDetailState.loading());
    try{
      final items = await _db.getItemsByCategoryId(id);
      emit(MoodboardDetailState.loaded(items));
    }catch(e){
      emit(const MoodboardDetailState.error());
    }
  }
}
