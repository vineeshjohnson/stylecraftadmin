part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}
final class LoadingState extends DashboardState {}


final class AllOrdersFetchedForDashboardState extends DashboardState {
  final int completeorders;
  final int cancelledorders;
  final int totalturnover;
  final int incompletedorders;

  final List<OrderModel> orders;
  final List<ProductModel> products;
  const AllOrdersFetchedForDashboardState(this.completeorders, this.cancelledorders, this.totalturnover, this.incompletedorders, 
      {required this.orders, required this.products});
}
