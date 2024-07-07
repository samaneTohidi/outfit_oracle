part of 'detail_cubit.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState.initial() = _Initial;
  const factory DetailState.loading() = _Loading;
  const factory DetailState.loaded(DetailViewModel detailViewModel ,DescriptionModel descriptionDetails, String title) = _Loaded;
  const factory DetailState.error() = _Error;

}
