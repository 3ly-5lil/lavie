part of 'filters_cubit.dart';

@immutable
abstract class FiltersState {}

class FiltersInitialState extends FiltersState {}

class FiltersFetchState extends FiltersState {}

class FiltersFetchErrorState extends FiltersState {}

class FiltersFetchSuccessState extends FiltersState {}
