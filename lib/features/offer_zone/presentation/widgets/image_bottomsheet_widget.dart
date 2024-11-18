import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageBottomSheet extends StatelessWidget {
  final File imageFile;

  const ImageBottomSheet({
    super.key,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              imageFile,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text("Close"),
              ),
              ElevatedButton(
                onPressed: () {
                  print('fdfdfdfdf');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("OK"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> uploadImageAndAddToBannerArray(File imageFile) async {
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

    print("Image uploaded and URL added to banners array successfully.");
  } catch (e) {
    print("Failed to upload image and update banners array: $e");
  }
}
