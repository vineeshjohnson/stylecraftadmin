part of 'product_adding_bloc.dart';

sealed class ProductAddingState extends Equatable {
  const ProductAddingState();
  
  @override
  List<Object> get props => [];
}

final class ProductAddingInitial extends ProductAddingState {}
