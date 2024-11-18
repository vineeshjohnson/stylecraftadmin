import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/bloc/products_bloc.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/widgets/product_tile.dart';
import 'package:flutter/material.dart';

Widget buildProductsGrid(BuildContext context, ProductsInitialFetched state) {
  return FutureBuilder<List<ProductModel>>(
    future: state.fetchProducts,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No products found.'));
      }

      final products = snapshot.data!;
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .70,
          crossAxisSpacing: 9.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductTileWidget(
            product: product,
            imageUrl: product.imagepath[0],
            name: product.name,
            brand: product.brand,
            category: product.category,
            price: product.price,
          );
        },
      );
    },
  );
}
