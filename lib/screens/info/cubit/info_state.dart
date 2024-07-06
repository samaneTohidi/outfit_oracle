part of 'info_cubit.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState.initial() = _Initial;
  const factory InfoState.loading() = _Loading;
  const factory InfoState.loaded(DetailViewModel detail) = _Loaded;
  const factory InfoState.error() = _Error;
}
