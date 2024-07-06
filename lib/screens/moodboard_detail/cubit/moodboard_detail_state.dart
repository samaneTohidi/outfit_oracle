part of 'moodboard_detail_cubit.dart';

@freezed
class MoodboardDetailState with _$MoodboardDetailState {
  const factory MoodboardDetailState.initial() = _Initial;
  const factory MoodboardDetailState.loaded() = _Loaded;
  const factory MoodboardDetailState.loading() = _Loading;
  const factory MoodboardDetailState.error() = _Error;

}
