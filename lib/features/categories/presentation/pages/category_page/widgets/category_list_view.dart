import 'package:finalprojectadmin/core/model/category_model.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/title_text.dart';
import 'package:finalprojectadmin/features/categories/presentation/pages/category_page/widgets/category_tile_widget.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  final Future<List<CategoryModel>> categoriesFuture;

  const CategoryListView({super.key, required this.categoriesFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching categories'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories available'));
        } else {
          return _buildCategoryGridView(snapshot.data!);
        }
      },
    );
  }

  Widget _buildCategoryGridView(List<CategoryModel> categories) {
    return Column(
      children: [
        const TitleText(
          title: 'Category Section',
          color: Colors.white,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return ProductTileWidget(
                  categoryName: category.category,
                  imagePath: category.imagepath,
                  id: category.id,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
