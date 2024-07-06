part of 'detail_cubit.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState.initial() = _Initial;
  const factory DetailState.loaded() = _Loaded;
  const factory DetailState.loading() = _Loading;
  const factory DetailState.error() = _Error;

}
