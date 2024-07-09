import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/collection_list_model.dart';
import '../../../models/detail_view_model.dart';
import '../../../repository/collection_list_request.dart';


part 'collection_state.dart';

part 'collection_cubit.freezed.dart';
class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(const CollectionState.initial());

  int limit = 10;
  int offset = 0;
  bool isLoading = false;
  List<Collections> collections = [];

  void loadCollections({bool loadMore = false}) async {
    if (isLoading) return;
    isLoading = true;
    if (loadMore) {
      offset += limit;
      print('SAM Loading more collections, new offset: $offset');
    } else {
      emit(const CollectionState.loading());
      offset = 0;
      collections.clear();
      print('SAM Initial load, resetting collections');
    }

    try {
      CollectionListModel data = await collectionListRequest(limit: limit, offset: offset);
      if (loadMore) {
        collections.addAll(data.collections ?? []);
      } else {
        collections = data.collections ?? [];
      }
      print('SAM Loaded ${collections?.length ?? 0} collections');
      emit(CollectionState.loaded(List.from(collections)));
    } catch (e) {
      print('SAM Error loading collections: $e');
      emit(const CollectionState.error());
    } finally {
      isLoading = false;
    }
  }
}