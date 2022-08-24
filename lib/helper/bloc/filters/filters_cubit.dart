import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lavie/shared/app_constants.dart';
import 'package:lavie/shared/cache_helper.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(FiltersInitialState()) {
    AppConstants.accessToken = CacheHelper.getString(SharedKeys.apiToken);
    AppConstants.dio.options.headers['Authorization'] =
        'Bearer ${AppConstants.accessToken}';
    fetchFilters();
  }

  late List<String> filters;

  fetchFilters() {
    filters = ['all'];
    emit(FiltersFetchState());
    AppConstants.dio
        .get('${AppConstants.apiBaseUrl}/api/v1/products/filters')
        .then((value) {
      Map data = value.data['data'];
      data.forEach((key, value) {
        filters.add(key);
      });
      emit(FiltersFetchSuccessState());
    }).onError((error, stackTrace) {
      if (error is DioError) {}
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
