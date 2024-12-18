import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? productId; // Add this field to store Firestore document ID
  String description;
  int price;
  String category;
  String name;
  String brand;
  int quantity;
  bool small;
  bool medium;
  bool large;
  bool xl;
  bool xxl;
  bool available;
  bool offeritem;
  bool cod;
  List<String> imagepath;
  int? discountpercent;

  ProductModel(
      {this.productId, // Include this in constructor
      required this.description,
      required this.price,
      required this.category,
      required this.name,
      required this.brand,
      required this.quantity,
      required this.small,
      required this.medium,
      required this.large,
      required this.xl,
      required this.xxl,
      required this.available,
      required this.offeritem,
      required this.cod,
      required this.imagepath,
      this.discountpercent});

  // Factory constructor to create a ProductModel from a Firestore document
  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProductModel(
        productId: doc.id, // Assign document ID as productId
        description: data['description'] ?? '',
        price: data['price'] ?? 0,
        category: data['category'] ?? '',
        name: data['name'] ?? '',
        brand: data['brand'] ?? '',
        quantity: data['quantity'] ?? 0,
        small: data['small'] ?? false,
        medium: data['medium'] ?? false,
        large: data['large'] ?? false,
        xl: data['xl'] ?? false,
        xxl: data['xxl'] ?? false,
        available: data['available'] ?? false,
        offeritem: data['offeritem'] ?? false,
        cod: data['cod'] ?? false,
        imagepath: List<String>.from(
          data['imagepath'] ?? [],
        ),
        discountpercent:
            data['discountpercent'] // Ensure imagepath is a list of strings
        );
  }

  // Method to create a list of ProductModels from a list of Firestore documents
  static List<ProductModel> fromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => ProductModel.fromDocument(doc)).toList();
  }
}
