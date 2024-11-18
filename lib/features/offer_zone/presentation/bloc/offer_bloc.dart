import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(OfferInitial()) {
    on<OfferEvent>((event, emit) {});

    on<OfferBannerFetchEvent>((event, emit) async {
      var list = await _fetchBannerUrls();
      emit(OfferBannerFetchedState(banners: list));
    });

    on<NavigateToAddBannerEvent>((event, emit) {
      emit(NavigatedToAddBannerState());
    });

    on<OfferBannerDeleteEvent>((event, emit) async {
      await deleteBannerImage(event.url);
      var list = await _fetchBannerUrls();
      emit(OfferBannerDeletedState());

      emit(OfferBannerFetchedState(banners: list));
    });
  }
}

Future<List<String>> _fetchBannerUrls() async {
  DocumentReference offerBannerRef =
      FirebaseFirestore.instance.collection('offerbanner').doc('banners');
  DocumentSnapshot snapshot = await offerBannerRef.get();

  List<dynamic> banners = snapshot.exists ? (snapshot['banner'] ?? []) : [];
  return List<String>.from(banners);
}

Future<void> deleteBannerImage(String imageUrl) async {
  try {
    DocumentReference offerBannerRef =
        FirebaseFirestore.instance.collection('offerbanner').doc('banners');

    DocumentSnapshot snapshot = await offerBannerRef.get();
    List<dynamic> currentBanners = snapshot['banner'] ?? [];

    if (currentBanners.contains(imageUrl)) {
      currentBanners.remove(imageUrl);

      await offerBannerRef.update({'banner': currentBanners});

      FirebaseStorage.instance.refFromURL(imageUrl).delete();

      print("Image URL removed from Firestore and file deleted from Storage.");
    } else {
      print("Image URL not found in banners array.");
    }
  } catch (e) {
    print("Failed to delete image URL from banners array: $e");
  }
}
