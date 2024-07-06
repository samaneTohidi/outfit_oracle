import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_state.dart';
part 'collection_cubit.freezed.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(const CollectionState.initial());
}
