import 'package:finalprojectadmin/features/products/presentation/pages/add_product_screen/add_product_screen.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/edit_product_screen/edit_product_screen.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_detail_screen/product_detail_screen.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/bloc/products_bloc.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/widgets_methods/dialoguebox_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void handleStateChange(
    BuildContext context, ProductsState state, String category) {
  if (state is FloatingActionButtonClickedState) {
    _navigateToAddProductScreen(context, category);
  } else if (state is ProductDoubleTappedState) {
    _navigateToProductDetailScreen(context, state.productId, category);
  } else if (state is DeleteButtonClickedState) {
    showDeleteConfirmationDialog(context, state.productId, category);
  } else if (state is EditButtonClickedState) {
    _navigateToEditProductScreen(context, state.productId, category);
  }
}

// Navigation: Add Product Screen
Future<void> _navigateToAddProductScreen(
    BuildContext context, String category) async {
  await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => AddProductScreen(category: category),
  ));
  context
      .read<ProductsBloc>()
      .add(InitialProductsFetchEvent(category: category));
}

// Navigation: Product Detail Screen
Future<void> _navigateToProductDetailScreen(
    BuildContext context, String productId, String category) async {
  await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => ProductDetailScreen(productId: productId),
  ));
  context
      .read<ProductsBloc>()
      .add(InitialProductsFetchEvent(category: category));
}

// Navigation: Edit Product Screen
Future<void> _navigateToEditProductScreen(
    BuildContext context, String productId, String category) async {
  await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => EditProductScreen(productId: productId),
  ));
  context
      .read<ProductsBloc>()
      .add(InitialProductsFetchEvent(category: category));
}
