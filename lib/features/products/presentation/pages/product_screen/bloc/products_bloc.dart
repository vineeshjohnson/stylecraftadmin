import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalprojectadmin/core/model/product_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {});

    on<InitialProductsFetchEvent>((event, emit) {
      var products = fethchproduct(event.category);

      emit(ProductsInitialFetched(fetchProducts: products));
    });

    on<FloatingActionButtonClickedEvent>((event, emit) {
      emit(FloatingActionButtonClickedState());
    });

    on<ProductDoubleTapEvent>((event, emit) {
      emit(ProductDoubleTappedState(productId: event.productid));
    });

    on<ProductEditClickEvent>((event, emit) {
      emit(EditButtonClickedState(productId: event.productid));
    });
    on<ProductDeleteClickedEvent>((event, emit) {
      emit(DeleteButtonClickedState(productId: event.productid));
    });
  }
}

Future<List<ProductModel>> fethchproduct(String category) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore
      .collection('products')
      .where('category', isEqualTo: category)
      .get();
  return querySnapshot.docs
      .map((doc) => ProductModel.fromDocument(doc))
      .toList();
}
