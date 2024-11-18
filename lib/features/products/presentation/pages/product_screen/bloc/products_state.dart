part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsInitialFetched extends ProductsState {
  const ProductsInitialFetched({required this.fetchProducts});
  final Future<List<ProductModel>> fetchProducts;
}

final class FloatingActionButtonClickedState extends ProductsState {}

final class ProductClickAndHoldState extends ProductsState {
  const ProductClickAndHoldState({required this.productId});
  final String productId;
}

final class ProductDoubleTappedState extends ProductsState {
  const ProductDoubleTappedState({required this.productId});
  final String productId;
}

final class DeleteButtonClickedState extends ProductsState {
  const DeleteButtonClickedState({required this.productId});
  final String productId;
}

final class EditButtonClickedState extends ProductsState {
  const EditButtonClickedState({required this.productId});
  final String productId;
}

final class ProductsErrorState extends ProductsState {
  const ProductsErrorState({required this.errormsg});
  final String errormsg;
}

final class ProductsLoadingState extends ProductsState {}
