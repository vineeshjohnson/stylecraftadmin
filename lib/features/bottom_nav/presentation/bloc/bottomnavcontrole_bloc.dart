import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomnavcontrole_event.dart';
part 'bottomnavcontrole_state.dart';

class BottomnavcontroleBloc
    extends Bloc<BottomnavcontroleEvent, BottomnavcontroleState> {
  BottomnavcontroleBloc() : super(BottomnavcontroleInitial()) {
    on<HomeEvent>((event, emit) {
      emit(BottomnavcontroleHomeState());
    });
    on<ShopEvent>((event, emit) {
      emit(BottomnavcontroleShopState());
    });
    on<CartEvent>((event, emit) {
      emit(BottomnavcontroleCartState());
    });
    on<ProfileEvent>((event, emit) {
      emit(BottomnavcontroleProfileState());
    });
  }
}
