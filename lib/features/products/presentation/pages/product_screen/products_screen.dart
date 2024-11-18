import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/functions/functions.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/widgets_methods/appbar_method.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/widgets_methods/floating_action_method.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/widgets_methods/productgrid_method.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/bloc/products_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  final String category;

  const ProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsBloc()..add(InitialProductsFetchEvent(category: category)),
      child: BlocConsumer<ProductsBloc, ProductsState>(
        buildWhen: (previous, current) {
          return previous is! ProductsInitialFetched;
        },
        listener: (context, state) {
          handleStateChange(context, state, category);
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey,
            appBar: buildAppBar(category),
            floatingActionButton: buildFloatingActionButton(context),
            body: state is ProductsInitialFetched
                ? buildProductsGrid(context, state)
                : const Center(child: Text('An error occurred.')),
          );
        },
      ),
    );
  }
}
