import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'addcategory_event.dart';
part 'addcategory_state.dart';

class AddcategoryBloc extends Bloc<AddcategoryEvent, AddcategoryState> {
  AddcategoryBloc() : super(AddcategoryInitial()) {
    // Handle the ImagePickingEvent
    on<ImagePickingEvent>((event, emit) async {
      try {
        var image = await pickImage();
        emit(ImagePickedState(image: image));
      } catch (e) {
        emit(ImagePickingFailedState(error: e.toString()));
      }
    });

    on<AddCategoryFinalEvent>((event, emit) async {
      try {
        emit(CategoryAddingLoadingState());
        await _uploadCategory(event.category, event.imagefile);
        emit(CategoryAddedState());
      } catch (e) {
        print(e.toString());
        emit(CategoryAddedFailureState());
      }
    });
  }
}

Future<XFile> pickImage() async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    return image; // If an image is selected, return it
  } else {
    throw Exception(
        "No image selected"); // Handle case where no image is selected
  }
}

Future<String> uploadImage(XFile image) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('category/$fileName');

  UploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));

  TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  return downloadUrl;
}

Future<void> addCategory(String categoryName, String imageUrl) async {
  await FirebaseFirestore.instance.collection('category').add({
    'category': categoryName,
    'imagepath': imageUrl,
  });
}

Future<void> _uploadCategory(String category, XFile? iamgepath) async {
  try {
    String imageUrl = await uploadImage(iamgepath!);

    await addCategory(category, imageUrl);
  } catch (e) {}
}
