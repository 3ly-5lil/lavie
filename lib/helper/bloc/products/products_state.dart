part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class ProductsStartFetchingState extends ProductsState {}

class ProductsFetchedSuccessfullyState extends ProductsState {}

class ProductsFetchedErrorState extends ProductsState {
  String? errorMessage;

  ProductsFetchedErrorState({this.errorMessage});
}

class SwitchFilterState extends ProductsState {}
