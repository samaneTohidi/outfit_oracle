part of 'moodboard_cubit.dart';

@freezed
class MoodboardState with _$MoodboardState {
  const factory MoodboardState.initial() = _Initial;
  const factory MoodboardState.loaded() = _Loaded;
  const factory MoodboardState.loading() = _Loading;
  const factory MoodboardState.error() = _Error;

}
