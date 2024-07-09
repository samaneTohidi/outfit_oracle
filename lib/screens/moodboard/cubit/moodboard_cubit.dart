import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../repository/moodboard_database.dart';
import '../../../widgets/sort_sheet.dart';

part 'moodboard_state.dart';
part 'moodboard_cubit.freezed.dart';

class MoodboardCubit extends Cubit<MoodboardState> {

  MoodboardCubit() : super(const MoodboardState.initial());

  final _db = MyDatabase.instance;

  Future<void> fetchCategories(SortData sortBy) async {
    emit(const MoodboardState.loading());

    try {
      final categories = await _db.getCategoriesSortedBy(sortBy);
      final itemCounts = <int, int>{};
      final items = <int, List<Item>>{};
      for (var category in categories) {
        itemCounts[category.id] = await _db.getItemCountByCategoryId(category.id);
        items[category.id] = await _db.getItemsByCategoryId(category.id);
      }
      emit(MoodboardState.loaded(categories, itemCounts, items));
    } catch (e) {
      emit(const MoodboardState.error());
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    await _db.deleteCategory(categoryId);
    fetchCategories(SortData.lastAdded);
  }

  Future<void> updateCategories(List<CategoryDB> updatedCategories) async {
    emit(MoodboardState.loaded(updatedCategories, {}, {}));
  }

  Future<void> addCategory(CategoriesCompanion category) async {
    await _db.addCategory(category);
  }

  Future<List<CategoryDB>> getCategories() async {
    return await _db.getCategories();
  }
}

