part of 'offer_bloc.dart';

sealed class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

final class OfferInitial extends OfferState {}

final class OfferBannerFetchedState extends OfferState {
  const OfferBannerFetchedState({required this.banners});
  final List<String> banners;
}

final class ImagePickedSTates extends OfferState {
  const ImagePickedSTates({required this.imagefile});
  final File imagefile;
}

final class OfferBannerAddedState extends OfferState {}

final class OfferBannerDeletedState extends OfferState {}

final class ErrorState extends OfferState {}

final class NavigatedToAddBannerState extends OfferState {}
