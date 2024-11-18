part of 'add_banner_bloc.dart';

sealed class AddBannerEvent extends Equatable {
  const AddBannerEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends AddBannerEvent {}

class ResetImageEvent extends AddBannerEvent {}

class BannerAddingEvent extends AddBannerEvent {
  const BannerAddingEvent({required this.image});
  final File image;
}
