part of 'offer_bloc.dart';

sealed class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class OfferBannerFetchEvent extends OfferEvent {}

class NavigateToAddBannerEvent extends OfferEvent {}

class OfferBannerDeleteEvent extends OfferEvent {
  final String url;
  const OfferBannerDeleteEvent({required this.url});
}
