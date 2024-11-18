import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/bloc/products_bloc.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDeleteConfirmationDialog(
    BuildContext context, String productId, String category) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context
                  .read<ProductsBloc>()
                  .add(InitialProductsFetchEvent(category: category));
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deleteProduct(context, productId, category);
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

Future<void> deleteProduct(
    BuildContext context, String productId, String category) async {
  FirebaseFirestore.instance
      .collection('products')
      .doc(productId)
      .delete()
      .then((_) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ProductsScreen(category: category)));
  });
}
