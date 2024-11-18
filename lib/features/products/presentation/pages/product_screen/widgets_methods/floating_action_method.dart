import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FloatingActionButton buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      context.read<ProductsBloc>().add(FloatingActionButtonClickedEvent());
    },
    child: const Icon(Icons.add),
  );
}
