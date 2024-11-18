part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class InitialProductsFetchEvent extends ProductsEvent {
  const InitialProductsFetchEvent({required this.category});
  final String category;
}

class FloatingActionButtonClickedEvent extends ProductsEvent {}

class ProductDoubleTapEvent extends ProductsEvent {
  const ProductDoubleTapEvent({required this.productid});
  final String productid;
}

class ProductEditClickEvent extends ProductsEvent {
  const ProductEditClickEvent({required this.productid});
  final String productid;
}

class ProductDeleteClickedEvent extends ProductsEvent {
  const ProductDeleteClickedEvent({required this.productid});
  final String productid;
}
