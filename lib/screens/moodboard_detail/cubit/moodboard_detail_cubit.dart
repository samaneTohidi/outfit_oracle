import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'moodboard_detail_state.dart';
part 'moodboard_detail_cubit.freezed.dart';

class MoodboardDetailCubit extends Cubit<MoodboardDetailState> {
  MoodboardDetailCubit() : super(const MoodboardDetailState.initial());
}
