import 'dart:io';

import 'package:finalprojectadmin/core/usecases/common_widgets/normal_button.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/snack_bar.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/title_text.dart';
import 'package:finalprojectadmin/features/offer_zone/presentation/screens/adding_banner/bloc/add_banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingBannerScreen extends StatelessWidget {
  const AddingBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    File? file;

    bool isloading = false;
    return BlocProvider(
      create: (context) => AddBannerBloc(),
      child: BlocConsumer<AddBannerBloc, AddBannerState>(
        listener: (context, state) {
          if (state is BannerAddedState) {
            isloading = false;
            snackBar(context, 'Banner Added Successfully');
          }
          if (state is LoadingState) {
            isloading = true;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const TitleText(title: 'Add New Banner'),
                    kheight40,
                    BlocSelector<AddBannerBloc, AddBannerState, File?>(
                      selector: (state) {
                        if (state is ImagePickedState) {
                          file = state.image;
                          return state.image;
                        } else if (state is ImageResetState) {
                          file = null;
                          return null;
                        }
                        return null;
                      },
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            image: DecorationImage(
                              image: state == null
                                  ? const AssetImage(
                                      'assets/images/noimage.avif')
                                  : FileImage(state) as ImageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                          height: 200,
                          width: 400,
                          child: Center(
                            child: isloading
                                ? const CircularProgressIndicator()
                                : const SizedBox(),
                          ),
                        );
                      },
                    ),
                    kheight60,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalButton(
                            onTap: () {
                              context
                                  .read<AddBannerBloc>()
                                  .add(PickImageEvent());
                            },
                            buttonTxt: 'Pick Image',
                            backGroundColor: Colors.black,
                            textColor: Colors.white),
                        NormalButton(
                            onTap: () {
                              context
                                  .read<AddBannerBloc>()
                                  .add(ResetImageEvent());
                            },
                            buttonTxt: 'Reset Image',
                            backGroundColor: Colors.black,
                            textColor: Colors.white)
                      ],
                    ),
                    kheight40,
                    NormalButton(
                        onTap: () {
                          if (file != null) {
                            context
                                .read<AddBannerBloc>()
                                .add(BannerAddingEvent(image: file!));
                          } else {
                            snackBar(context, 'No banner selected');
                          }
                        },
                        buttonTxt: 'Add Banner',
                        backGroundColor: Colors.blueAccent,
                        textColor: Colors.white)
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
