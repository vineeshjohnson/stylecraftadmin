import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojectadmin/features/bottom_nav/presentation/pages/bottom_navigation_bar.dart';
import 'package:finalprojectadmin/features/categories/presentation/pages/add_category_page/addcategory_page.dart';
import 'package:finalprojectadmin/features/categories/presentation/pages/category_page/bloc/category_bloc.dart';
import 'package:finalprojectadmin/features/categories/presentation/pages/category_page/widgets/category_list_view.dart';
import 'package:finalprojectadmin/features/categories/presentation/pages/category_page/widgets/floating_action_button.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(InitialfetchEvent()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade800,
            centerTitle: true,
            title: const Text(
              'Product Categories',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.grey,
          floatingActionButton: const FloatingActionButtonForAddingCategory(),
          body: BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is AddProductState) {
                _navigateToAddCategoryPage(context);
              } else if (state is NavigateToProductsScreenState) {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => ProductsScreen(
                              category: state.category,
                            )))
                    .then((_) {
                  // Trigger the fetch event again when coming back to CategoryPage
                  context.read<CategoryBloc>().add(InitialfetchEvent());
                });
              } else if (state is DeletingState) {
                _deleteCategory(context, state.category, state.id);
                context.read<CategoryBloc>().add(InitialfetchEvent());
              }
            },
            builder: (context, state) {
              if (state is FetchInitialState) {
                return CategoryListView(categoriesFuture: state.model);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  void _navigateToAddCategoryPage(BuildContext context) {
    Navigator.of(context)
        .push(
            MaterialPageRoute(builder: (context) => const AddCategoryScreen()))
        .then((_) {
      // Trigger the fetch event again when coming back to CategoryPage
      context.read<CategoryBloc>().add(InitialfetchEvent());
    });
  }
}

void _deleteCategory(BuildContext context, String category, String id) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this Category?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('category')
                  .doc(id)
                  .delete()
                  .then((_) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const BottomNavigationBars()));
              });
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
