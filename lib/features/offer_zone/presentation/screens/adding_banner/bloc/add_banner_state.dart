part of 'add_banner_bloc.dart';

sealed class AddBannerState extends Equatable {
  const AddBannerState();

  @override
  List<Object> get props => [];
}

final class AddBannerInitial extends AddBannerState {}

final class ImagePickedState extends AddBannerState {
  final File image;
  const ImagePickedState({required this.image});
}

class ImageResetState extends AddBannerState {}

class LoadingState extends AddBannerState {}

class BannerAddedState extends AddBannerState {}

class ErrorState extends AddBannerState {}
