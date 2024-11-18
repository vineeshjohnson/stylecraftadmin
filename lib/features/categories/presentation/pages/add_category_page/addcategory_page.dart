import 'package:finalprojectadmin/core/usecases/common_widgets/normal_button.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/text_form_field.dart';
import 'package:finalprojectadmin/features/bottom_nav/presentation/pages/bottom_navigation_bar.dart';
import 'package:finalprojectadmin/features/categories/presentation/pages/add_category_page/bloc/addcategory_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  AddCategoryScreenState createState() => AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryController = TextEditingController();

  XFile? _imageFile;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddcategoryBloc(),
      child: BlocConsumer<AddcategoryBloc, AddcategoryState>(
        listener: (context, state) {
          if (state is ImagePickedState) {
            _imageFile = state.image;
          } else if (state is CategoryAddedState) {
            Navigator.pushAndRemoveUntil(
                context,
                (MaterialPageRoute(
                    builder: (context) => const BottomNavigationBars())),
                (route) => false);
          }
          if (state is CategoryAddingLoadingState) {
            isLoading = true;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add New Category'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<AddcategoryBloc>()
                            .add((ImagePickingEvent()));
                      },
                      child: Container(
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 50, color: Colors.grey),
                                  Text('Add Image',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_imageFile!.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Textformfields(
                        controller: _categoryController,
                        icon: const Icon(Icons.category),
                        labeltext: 'Category Name'),
                    kheight30,
                    isLoading
                        ? const CircularProgressIndicator()
                        : NormalButton(
                            onTap: () {
                              print("add catgory button clicked");
                              if (_imageFile == null ||
                                  _categoryController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Fill all fields')),
                                );
                              } else {
                                context.read<AddcategoryBloc>().add(
                                    (AddCategoryFinalEvent(
                                        imagefile: _imageFile!,
                                        category: _categoryController.text)));
                              }
                            },
                            buttonTxt: 'Add Category',
                            backGroundColor: Colors.black,
                            textColor: Colors.white),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
