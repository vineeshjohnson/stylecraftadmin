import 'package:flutter/material.dart';

AppBar buildAppBar(String category) {
  return AppBar(
    backgroundColor: Colors.black,
    centerTitle: true,
    title: Text(
      'Products in $category',
      style: const TextStyle(color: Colors.white),
    ),
  );
}
