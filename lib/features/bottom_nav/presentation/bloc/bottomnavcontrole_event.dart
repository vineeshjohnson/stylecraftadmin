part of 'bottomnavcontrole_bloc.dart';

sealed class BottomnavcontroleEvent extends Equatable {
  const BottomnavcontroleEvent();

  @override
  List<Object> get props => [];
}

class HomeEvent extends BottomnavcontroleEvent {}

class ShopEvent extends BottomnavcontroleEvent {}

class CartEvent extends BottomnavcontroleEvent {}

class ProfileEvent extends BottomnavcontroleEvent {}
