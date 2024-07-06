part of 'collection_cubit.dart';

@freezed
class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loaded() = _Loaded;
  const factory CollectionState.loading() = _Loading;
  const factory CollectionState.error() = _Error;


}
