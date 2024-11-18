// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class InitialfetchEvent extends CategoryEvent {}

class ProductsEvent extends CategoryEvent {
  final String category;
  const ProductsEvent({
    required this.category,
  });
}

class AddCategoryEvent extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {
  const DeleteCategoryEvent({
    required this.category,
    required this.id,
  });
  final String category;
  final String id;
}
