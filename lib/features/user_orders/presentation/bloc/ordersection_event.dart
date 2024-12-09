part of 'ordersection_bloc.dart';

sealed class OrdersectionEvent extends Equatable {
  const OrdersectionEvent();

  @override
  List<Object> get props => [];
}

class FetchAllOrderEvent extends OrdersectionEvent {}

class OrderHandlingEvent extends OrdersectionEvent {
  final String orderstate;
  final OrderModel order;
  final ProductModel product;
  const OrderHandlingEvent(
      {required this.order, required this.product, required this.orderstate});
}

class NavigatedToOrderDetailedPage extends OrdersectionEvent {
  final OrderModel order;
  final ProductModel product;
  const NavigatedToOrderDetailedPage(
      {required this.order, required this.product});
}
