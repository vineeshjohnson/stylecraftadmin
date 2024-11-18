import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'add_banner_event.dart';
part 'add_banner_state.dart';

class AddBannerBloc extends Bloc<AddBannerEvent, AddBannerState> {
  AddBannerBloc() : super(AddBannerInitial()) {
    on<AddBannerEvent>((event, emit) {});

    on<PickImageEvent>((event, emit) async {
      var v = await imagepick();

      if (v != null) {
        emit(ImagePickedState(image: v));
      }
    });

    on<ResetImageEvent>((event, emit) async {
      emit(ImageResetState());
    });

    on<BannerAddingEvent>((event, emit) async {
      emit(LoadingState());
      bool uploadSuccess = await uploadImageAndAddToBannerArray(event.image);
      if (uploadSuccess) {
        emit(BannerAddedState());
        emit(ImageResetState());
      }
    });
  }
}

Future<File?> imagepick() async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    return null;
  }
}

Future<bool> uploadImageAndAddToBannerArray(File imageFile) async {
  bool flag = false;
  try {
    String filePath =
        'offerbanner/${DateTime.now().millisecondsSinceEpoch}.png';

    final uploadTask =
        await FirebaseStorage.instance.ref(filePath).putFile(imageFile);

    // Get the download URL for the uploaded image
    String downloadUrl = await uploadTask.ref.getDownloadURL();

    // Reference to the specific `offerbanner` document
    DocumentReference offerBannerRef =
        FirebaseFirestore.instance.collection('offerbanner').doc('banners');

    // Retrieve the current banners array
    DocumentSnapshot snapshot = await offerBannerRef.get();
    List<dynamic> currentBanners = snapshot['banner'] ?? [];

    // Add the new URL to the array
    currentBanners.add(downloadUrl);

    // Update the Firestore document with the new array
    await offerBannerRef.update({'banner': currentBanners});
    flag = true;
    print("Image uploaded and URL added to banners array successfully.");

    return flag;
  } catch (e) {
    print("Failed to upload image and update banners array: $e");
    return flag;
  }
}
