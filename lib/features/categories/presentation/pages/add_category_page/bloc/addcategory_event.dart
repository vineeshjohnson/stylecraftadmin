part of 'addcategory_bloc.dart';

sealed class AddcategoryEvent extends Equatable {
  const AddcategoryEvent();

  @override
  List<Object> get props => [];
}

class ImagePickingEvent extends AddcategoryEvent {}

class AddCategoryFinalEvent extends AddcategoryEvent {
  final XFile imagefile;
  final String category;

  const AddCategoryFinalEvent(
      {required this.imagefile, required this.category});
}
