part of 'moodboard_cubit.dart';

@freezed
class MoodboardState with _$MoodboardState {
  const factory MoodboardState.initial() = _Initial;
  const factory MoodboardState.loading() = _Loading;
  const factory MoodboardState.loaded(
      List<CategoryDB> categories,
      Map<int, int> itemCounts,
      Map<int, List<Item>> items,
      ) = _Loaded;
  const factory MoodboardState.error() = _Error;

}
