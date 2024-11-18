import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:finalprojectadmin/features/products/presentation/pages/product_screen/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({
    super.key,
    required this.product,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
  });

  final ProductModel product;
  final String imageUrl;
  final String name;
  final String brand;
  final String category;
  final int price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        context
            .read<ProductsBloc>()
            .add(ProductDoubleTapEvent(productid: product.productId!));
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.broken_image));
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.7),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Brand: $brand',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Category: $category',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$$price',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.white),
                                onPressed: () {
                                  context.read<ProductsBloc>().add(
                                      ProductDeleteClickedEvent(
                                          productid: product.productId!));
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  context.read<ProductsBloc>().add(
                                      ProductEditClickEvent(
                                          productid: product.productId!));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
