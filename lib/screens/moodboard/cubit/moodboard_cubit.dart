import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'moodboard_state.dart';
part 'moodboard_cubit.freezed.dart';

class MoodboardCubit extends Cubit<MoodboardState> {
  MoodboardCubit() : super(const MoodboardState.initial());
}
