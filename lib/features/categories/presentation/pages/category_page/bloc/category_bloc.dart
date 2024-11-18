import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalprojectadmin/core/model/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      var model = fetchCategories();
      emit(FetchInitialState(model: model));
    });

    on<AddCategoryEvent>(
      (event, emit) => emit(AddProductState()),
    );

    on<ProductsEvent>(
      (event, emit) =>
          emit(NavigateToProductsScreenState(category: event.category)),
    );
    on<DeleteCategoryEvent>(
      (event, emit) =>
          emit(DeletingState(category: event.category, id: event.id)),
    );
  }
}

Future<List<CategoryModel>> fetchCategories() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await firestore.collection('category').get();
  return snapshot.docs.map((doc) => CategoryModel.fromFirestore(doc)).toList();
}
