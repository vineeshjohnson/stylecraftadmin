part of 'bottomnavcontrole_bloc.dart';

sealed class BottomnavcontroleState extends Equatable {
  const BottomnavcontroleState();

  @override
  List<Object> get props => [];
}

final class BottomnavcontroleInitial extends BottomnavcontroleState {}

final class BottomnavcontroleHomeState extends BottomnavcontroleState {}

final class BottomnavcontroleShopState extends BottomnavcontroleState {}

final class BottomnavcontroleCartState extends BottomnavcontroleState {}

final class BottomnavcontroleProfileState extends BottomnavcontroleState {}
