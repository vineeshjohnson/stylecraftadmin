import 'dart:io';
import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/usecases/common_widgets/text_form_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, required this.category});
  final String category;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile?> _selectedImages = List.filled(3, null);

  bool small = false;
  bool medium = false;
  bool large = false;
  bool xl = false;
  bool xxl = false;

  bool available = false;
  bool offerItem = false;
  bool cod = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImages[index] = image;
      });
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> downloadUrls = [];
    for (XFile? image in _selectedImages) {
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

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      // Upload images and get the URLs
      List<String> imageUrls = await _uploadImages();
      if (imageUrls.length < 3) {
        snackBar(context, 'Images are mandatory');
      }
      // Create product data
      ProductModel product = ProductModel(
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        category: widget.category,
        name: _nameController.text,
        brand: _brandController.text,
        quantity: int.parse(_quantityController.text),
        small: small,
        medium: medium,
        large: large,
        xl: xl,
        xxl: xxl,
        available: available,
        offeritem: offerItem,
        cod: cod,
        imagepath: imageUrls,
      );

      // Add product data to Firestore
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
        'imagepath': product.imagepath,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );

      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _quantityController.clear();
      _brandController.clear();
      setState(() {
        _selectedImages = List.filled(3, null);
        small = false;
        medium = false;
        large = false;
        xl = false;
        xxl = false;
        available = false;
        offerItem = false;
        cod = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Textformfields(
                controller: _nameController,
                icon: const Icon(Icons.shopping_bag),
                labeltext: 'Product Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Description
              Textformfields(
                controller: _descriptionController,
                icon: const Icon(Icons.description),
                labeltext: 'Description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Price
              Textformfields(
                controller: _priceController,
                icon: const Icon(Icons.attach_money),
                labeltext: 'Price',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Quantity
              Textformfields(
                controller: _quantityController,
                icon: const Icon(Icons.format_list_numbered),
                labeltext: 'Quantity',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Brand
              Textformfields(
                controller: _brandController,
                icon: const Icon(Icons.branding_watermark),
                labeltext: 'Brand',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter brand';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Category (disabled)
              Textformfields(
                enabled: false,
                controller: TextEditingController(text: widget.category),
                icon: const Icon(Icons.category),
                labeltext: 'Category',
                validator: null,
              ),
              const SizedBox(height: 20),

              // Image Pickers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () => _pickImage(index),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _selectedImages[index] == null
                          ? const Icon(Icons.add_a_photo,
                              size: 50, color: Colors.grey)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_selectedImages[index]!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Sizes - Vertical Column Layout
              const Text("Available Sizes:"),
              Column(
                children: [
                  CheckboxListTile(
                    value: small,
                    onChanged: (bool? value) {
                      setState(() {
                        small = value!;
                      });
                    },
                    title: const Text('Small'),
                  ),
                  CheckboxListTile(
                    value: medium,
                    onChanged: (bool? value) {
                      setState(() {
                        medium = value!;
                      });
                    },
                    title: const Text('Medium'),
                  ),
                  CheckboxListTile(
                    value: large,
                    onChanged: (bool? value) {
                      setState(() {
                        large = value!;
                      });
                    },
                    title: const Text('Large'),
                  ),
                  CheckboxListTile(
                    value: xl,
                    onChanged: (bool? value) {
                      setState(() {
                        xl = value!;
                      });
                    },
                    title: const Text('XL'),
                  ),
                  CheckboxListTile(
                    value: xxl,
                    onChanged: (bool? value) {
                      setState(() {
                        xxl = value!;
                      });
                    },
                    title: const Text('XXL'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Product Availability, Offer, COD - Vertical Column Layout
              const Text("Options:"),
              Column(
                children: [
                  CheckboxListTile(
                    value: available,
                    onChanged: (bool? value) {
                      setState(() {
                        available = value!;
                      });
                    },
                    title: const Text('Available'),
                  ),
                  CheckboxListTile(
                    value: offerItem,
                    onChanged: (bool? value) {
                      setState(() {
                        offerItem = value!;
                      });
                    },
                    title: const Text('Offer Item'),
                  ),
                  CheckboxListTile(
                    value: cod,
                    onChanged: (bool? value) {
                      setState(() {
                        cod = value!;
                      });
                    },
                    title: const Text('Cash on Delivery'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _addProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
