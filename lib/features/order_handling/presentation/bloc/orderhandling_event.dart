part of 'orderhandling_bloc.dart';

sealed class OrderhandlingEvent extends Equatable {
  const OrderhandlingEvent();

  @override
  List<Object> get props => [];
}

class FetchingAllOrdersEvent extends OrderhandlingEvent {}

class OrderUpdatingEvent extends OrderhandlingEvent {
  final OrderModel ordermodel;
  final String orderstate;
  const OrderUpdatingEvent(
      {required this.ordermodel, required this.orderstate});
}
