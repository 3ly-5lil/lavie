import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lavie/shared/app_constants.dart';

import '../../../api_models/products/Product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitialState()) {
    fetchProducts();
  }

  List<Product> products = [];
  List<Product> plants = [];
  List<Product> seeds = [];
  List<Product> tools = [];

  fetchProducts() async {
    if (products.isNotEmpty) return;
    emit(ProductsStartFetchingState());
    await AppConstants.dio
        .get('${AppConstants.apiBaseUrl}/api/v1/products')
        .then((value) {
      for (var element in value.data['data']) {
        products.add(Product.fromJson(element));
        if (products.last.type == 'PLANT') plants.add(products.last);
        if (products.last.type == 'SEED') seeds.add(products.last);
        if (products.last.type == 'TOOL') tools.add(products.last);
      }
      emit(ProductsFetchedSuccessfullyState());
    }).onError((error, stackTrace) {
      if (error is DioError) {
        emit(
          ProductsFetchedErrorState(
            errorMessage: error.response!.data['message'],
          ),
        );
      } else {
        debugPrint(error.toString());
        emit(ProductsFetchedErrorState());
      }
    });
  }

  switchFilter() {
    emit(SwitchFilterState());
  }
}
