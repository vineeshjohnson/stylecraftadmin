import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/normal_button.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/snack_bar.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/text_form_field.dart';
import 'package:finalprojectadmin/features/products/data/product_helper.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, required this.category});
  final String category;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  // Image Pickers
  List<XFile?> _selectedImages = List.filled(3, null);

  // Helper class
  final ProductHelper _productHelper = ProductHelper();

  // Loading State
  bool isLoading = false;

  // Product Attributes
  final Map<String, bool> sizes = {
    'Small': false,
    'Medium': false,
    'Large': false,
    'XL': false,
    'XXL': false,
  };

  final Map<String, bool> options = {
    'Available': false,
    'Offer Item': false,
    'Cash on Delivery': false,
  };

  // Pick Image Method
  Future<void> _pickImage(int index) async {
    final XFile? image = await _productHelper.pickImage();
    if (image != null) {
      setState(() {
        _selectedImages[index] = image;
      });
    }
  }

  // Add Product Method
  Future<void> _addProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final product = ProductModel(
        name: _nameController.text,
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        category: widget.category,
        brand: _brandController.text,
        quantity: int.parse(_quantityController.text),
        small: sizes['Small']!,
        medium: sizes['Medium']!,
        large: sizes['Large']!,
        xl: sizes['XL']!,
        xxl: sizes['XXL']!,
        available: options['Available']!,
        offeritem: options['Offer Item']!,
        cod: options['Cash on Delivery']!,
        imagepath: [],
      );

      await _productHelper.addProduct(product, _selectedImages);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
      _resetForm();
    } catch (e) {
      snackBar(context, e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Reset Form Method
  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _quantityController.clear();
    _brandController.clear();
    setState(() {
      _selectedImages = List.filled(3, null);
      sizes.updateAll((key, value) => false);
      options.updateAll((key, value) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  _nameController, 'Product Name', Icons.shopping_bag),
              _buildTextField(
                  _descriptionController, 'Description', Icons.description),
              _buildTextField(_priceController, 'Price', Icons.attach_money,
                  keyboardType: TextInputType.number),
              _buildTextField(
                  _quantityController, 'Quantity', Icons.format_list_numbered,
                  keyboardType: TextInputType.number),
              _buildTextField(
                  _brandController, 'Brand', Icons.branding_watermark),
              _buildDisabledTextField(
                  widget.category, 'Category', Icons.category),
              const SizedBox(height: 20),
              _buildImagePickers(),
              const SizedBox(height: 20),
              _buildCheckboxGroup('Available Sizes:', sizes),
              const SizedBox(height: 20),
              _buildCheckboxGroup('Options:', options),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : NormalButton(
                      onTap: _addProduct,
                      buttonTxt: 'Add Product',
                      backGroundColor: Colors.black,
                      textColor: Colors.white,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType? keyboardType}) {
    return Column(
      children: [
        Textformfields(
          controller: controller,
          icon: Icon(icon),
          labeltext: label,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label.toLowerCase()';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDisabledTextField(String value, String label, IconData icon) {
    return Textformfields(
      enabled: false,
      controller: TextEditingController(text: value),
      icon: Icon(icon),
      labeltext: label,
    );
  }

  Widget _buildImagePickers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        3,
        (index) => GestureDetector(
          onTap: () => _pickImage(index),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _selectedImages[index] == null
                ? const Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(_selectedImages[index]!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxGroup(String title, Map<String, bool> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...items.entries.map((entry) {
          return CheckboxListTile(
            title: Text(entry.key),
            value: entry.value,
            onChanged: (value) {
              setState(() {
                items[entry.key] = value!;
              });
            },
          );
        }).toList(),
      ],
    );
  }
}
