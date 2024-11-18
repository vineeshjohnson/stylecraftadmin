// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class FetchInitialState extends CategoryState {
  final Future<List<CategoryModel>> model;
  const FetchInitialState({required this.model});
}

class AddProductState extends CategoryState {}

class NavigateToProductsScreenState extends CategoryState {
  final String category;
  const NavigateToProductsScreenState({required this.category});
}

class DeletingState extends CategoryState {
  final String id;
  final String category;
  const DeletingState({
    required this.id,
    required this.category,
  });
}
