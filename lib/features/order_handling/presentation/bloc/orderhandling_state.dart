part of 'orderhandling_bloc.dart';

sealed class OrderhandlingState extends Equatable {
  const OrderhandlingState();

  @override
  List<Object> get props => [];
}

final class OrderhandlingInitial extends OrderhandlingState {}

final class AllOrdersFetchedState extends OrderhandlingState {
  final List<OrderModel> ordermodels;
  const AllOrdersFetchedState({required this.ordermodels});
}

final class LoadingState extends OrderhandlingState {}
