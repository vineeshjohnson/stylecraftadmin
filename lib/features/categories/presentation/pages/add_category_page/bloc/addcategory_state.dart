part of 'addcategory_bloc.dart';

sealed class AddcategoryState extends Equatable {
  const AddcategoryState();

  @override
  List<Object> get props => [];
}

final class AddcategoryInitial extends AddcategoryState {}

final class ImagePickedState extends AddcategoryState {
  final XFile image;

  const ImagePickedState({required this.image});
}

class ImagePickingFailedState extends AddcategoryState {
  final String error;

  const ImagePickingFailedState({required this.error});
}

class CategoryAddedState extends AddcategoryState {}

class CategoryAddedFailureState extends AddcategoryState {}

class CategoryAddingLoadingState extends AddcategoryState {}

class CategoryAddingNullState extends AddcategoryState {}
