part of 'ordersection_bloc.dart';

sealed class OrdersectionState extends Equatable {
  const OrdersectionState();

  @override
  List<Object> get props => [];
}

final class OrdersectionInitial extends OrdersectionState {}

final class AllOrdersFetchedState extends OrdersectionState {
  final List<OrderModel> orders;
  final List<ProductModel> products;
  const AllOrdersFetchedState({
    required this.orders,
    required this.products,
  });
}

final class LoadingState extends OrdersectionState {}

final class OrderUpdatedState extends OrdersectionState {
  final bool success;
  OrderUpdatedState({required this.success});
}

final class NavigatedToPageState extends OrdersectionState {
  final OrderModel order;
  final ProductModel product;
  const NavigatedToPageState({required this.order, required this.product});
}
