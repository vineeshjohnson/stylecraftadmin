import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_adding_event.dart';
part 'product_adding_state.dart';

class ProductAddingBloc extends Bloc<ProductAddingEvent, ProductAddingState> {
  ProductAddingBloc() : super(ProductAddingInitial()) {
    on<ProductAddingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
