import 'package:finalprojectadmin/features/categories/presentation/pages/category_page/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTileWidget extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final String id;

  const ProductTileWidget({
    super.key,
    required this.categoryName,
    required this.imagePath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context
            .read<CategoryBloc>()
            .add(DeleteCategoryEvent(category: categoryName, id: id));
      },
      onTap: () {
        context
            .read<CategoryBloc>()
            .add((ProductsEvent(category: categoryName)));
      },
      child: Container(
        height: 300,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network(
                imagePath,
                fit: BoxFit.fill,
                height: 300,
                width: 200,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    categoryName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
