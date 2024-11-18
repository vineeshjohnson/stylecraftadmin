import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Product not found.'));
          }

          final product = snapshot.data!.data() as Map<String, dynamic>;

          // Safely handle potential null values by providing defaults
          final name = product['name'] ?? 'Unnamed Product';
          final price = product['price'] ?? 0;
          final description = product['description'] ?? 'No description';
          final brand = product['brand'] ?? 'Unknown';
          final quantity = product['quantity'] ?? 0;
          final small = product['small'] ?? false;
          final medium = product['medium'] ?? false;
          final large = product['large'] ?? false;
          final xl = product['xl'] ?? false;
          final xxl = product['xxl'] ?? false;
          final imagepath = product['imagepath'] as List<dynamic>? ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Product Price
                Text(
                  'Price: \$${price.toString()}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),

                // Product Description
                Text(
                  'Description: $description',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),

                // Product Brand
                Text(
                  'Brand: $brand',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),

                // Product Quantity
                Text(
                  'Quantity: ${quantity.toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                // Available Sizes
                const Text('Available Sizes:', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  children: [
                    Chip(label: Text('Small: ${small ? 'Yes' : 'No'}')),
                    Chip(label: Text('Medium: ${medium ? 'Yes' : 'No'}')),
                    Chip(label: Text('Large: ${large ? 'Yes' : 'No'}')),
                    Chip(label: Text('XL: ${xl ? 'Yes' : 'No'}')),
                    Chip(label: Text('XXL: ${xxl ? 'Yes' : 'No'}')),
                  ],
                ),
                const SizedBox(height: 16),

                // Product Images Section
                const Text('Images:', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagepath.length,
                    itemBuilder: (context, index) {
                      final imageUrl = imagepath[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
