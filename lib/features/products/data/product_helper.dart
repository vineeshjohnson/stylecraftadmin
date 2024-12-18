import 'dart:io';
import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductHelper {
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<XFile?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  // Function to upload images to Firebase Storage
  Future<List<String>> uploadImages(List<XFile?> selectedImages) async {
    List<String> downloadUrls = [];
    for (XFile? image in selectedImages) {
      if (image != null) {
        File file = File(image.path);
        String fileName =
            'products/${DateTime.now().millisecondsSinceEpoch}.png';
        UploadTask uploadTask =
            FirebaseStorage.instance.ref(fileName).putFile(file);

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    }
    return downloadUrls;
  }

  Future<void> addProduct(
      ProductModel product, List<XFile?> selectedImages) async {
    if (selectedImages.any((image) => image == null)) {
      throw Exception('Images are mandatory');
    }

    List<String> imageUrls = await uploadImages(selectedImages);

    await FirebaseFirestore.instance.collection('products').add({
      'description': product.description,
      'price': product.price,
      'category': product.category,
      'name': product.name,
      'brand': product.brand,
      'quantity': product.quantity,
      'small': product.small,
      'medium': product.medium,
      'large': product.large,
      'xl': product.xl,
      'xxl': product.xxl,
      'available': product.available,
      'offeritem': product.offeritem,
      'cod': product.cod,
      'imagepath': imageUrls,
      'discountpercent': product.discountpercent
    });
  }
}
