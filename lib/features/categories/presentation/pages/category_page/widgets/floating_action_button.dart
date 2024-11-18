import 'package:finalprojectadmin/features/categories/presentation/pages/category_page/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionButtonForAddingCategory extends StatelessWidget {
  const FloatingActionButtonForAddingCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CategoryBloc>().add((AddCategoryEvent()));
      },
      child: const Icon(Icons.add),
    );
  }
}
