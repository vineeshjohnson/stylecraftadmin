// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finalprojectadmin/features/products/presentation/pages/edit_product_screen/edit_product_screen.dart';
// import 'package:finalprojectadmin/features/products/presentation/pages/product_detail_screen/product_detail_screen.dart';
// import 'package:flutter/material.dart';

// void showPopupMenu(BuildContext context, String productId, String category) {
//   showMenu(
//     context: context,
//     position: const RelativeRect.fromLTRB(100, 100, 0, 0),
//     items: [
//       const PopupMenuItem(
//         value: 'edit',
//         child: Row(
//           children: [
//             Icon(Icons.edit),
//             SizedBox(width: 8),
//             Text('Edit'),
//           ],
//         ),
//       ),
//       const PopupMenuItem(
//         value: 'delete',
//         child: Row(
//           children: [
//             Icon(Icons.delete),
//             SizedBox(width: 8),
//             Text('Delete'),
//           ],
//         ),
//       ),
//     ],
//   ).then((value) {
//     if (value == 'edit') {
//       // Handle the edit action
//       _editProduct(context, productId, category);
//     } else if (value == 'delete') {
//       // Handle the delete action
//       _deleteProduct(context, productId);
//     }
//   });
// }

// void _editProduct(BuildContext context, String productId, String category) {
//   // Navigate to the edit screen with the product ID
//   Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => EditProductScreen(
//         productId: productId, category: category), // Adjust accordingly
//   ));
// }

// void _deleteProduct(BuildContext context, String productId) {
//   // Confirm deletion
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Confirm Delete'),
//         content: const Text('Are you sure you want to delete this product?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               FirebaseFirestore.instance
//                   .collection('products')
//                   .doc(productId)
//                   .delete()
//                   .then((_) {
//                 Navigator.of(context).pop(); // Close the dialog
//               });
//             },
//             child: const Text('Delete'),
//           ),
//         ],
//       );
//     },
//   );
// }

// // New method to navigate to Product Detail Screen
// void _navigateToDetailScreen(BuildContext context, String productId) {
//   Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => ProductDetailScreen(productId: productId),
//   ));
// }
