part of 'collection_cubit.dart';

@freezed
class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loading() = _Loading;
  const factory CollectionState.loaded(List<Collections> collections) = _Loaded;
  const factory CollectionState.error() = _Error;


}
