import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/text_form_field.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  const EditProductScreen({super.key, required this.productId});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  bool small = false;
  bool medium = false;
  bool large = false;
  bool xl = false;
  bool xxl = false;
  bool available = false;
  bool offerItem = false;
  bool cod = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    final productDoc = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get();
    final product = productDoc.data();

    if (product != null) {
      setState(() {
        // Ensure state is updated
        _nameController.text = product['name'] ?? '';
        _descriptionController.text = product['description'] ?? '';
        _priceController.text = product['price'].toString();
        _quantityController.text = product['quantity'].toString();
        _brandController.text = product['brand'] ?? '';
        small = product['small'] ?? false;
        medium = product['medium'] ?? false;
        large = product['large'] ?? false;
        xl = product['xl'] ?? false;
        xxl = product['xxl'] ?? false;
        available = product['available'] ?? false;
        offerItem = product['offeritem'] ?? false;
        cod = product['cod'] ?? false;
      });
    }
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .update({
          'name': _nameController.text,
          'description': _descriptionController.text,
          'price': int.parse(_priceController.text),
          'quantity': int.parse(_quantityController.text),
          'brand': _brandController.text,
          'small': small,
          'medium': medium,
          'large': large,
          'xl': xl,
          'xxl': xxl,
          'available': available,
          'offeritem': offerItem,
          'cod': cod,
        });

        Navigator.of(context).pop(); // Go back after updating
      } catch (e) {
        print('Error updating product: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update product')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Product Name
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

              // Sizes
              const Text("Available Sizes:"),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: small,
                        onChanged: (bool? value) {
                          setState(() {
                            small = value!;
                          });
                        },
                      ),
                      const Text('Small'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: medium,
                        onChanged: (bool? value) {
                          setState(() {
                            medium = value!;
                          });
                        },
                      ),
                      const Text('Medium'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: large,
                        onChanged: (bool? value) {
                          setState(() {
                            large = value!;
                          });
                        },
                      ),
                      const Text('Large'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: xl,
                        onChanged: (bool? value) {
                          setState(() {
                            xl = value!;
                          });
                        },
                      ),
                      const Text('XL'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: xxl,
                        onChanged: (bool? value) {
                          setState(() {
                            xxl = value!;
                          });
                        },
                      ),
                      const Text('XXL'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Product Availability, Offer, COD
              const Text("Options:"),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: available,
                        onChanged: (bool? value) {
                          setState(() {
                            available = value!;
                          });
                        },
                      ),
                      const Text('Available'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: offerItem,
                        onChanged: (bool? value) {
                          setState(() {
                            offerItem = value!;
                          });
                        },
                      ),
                      const Text('Offer Item'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: cod,
                        onChanged: (bool? value) {
                          setState(() {
                            cod = value!;
                          });
                        },
                      ),
                      const Text('COD Available'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _updateProduct,
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
