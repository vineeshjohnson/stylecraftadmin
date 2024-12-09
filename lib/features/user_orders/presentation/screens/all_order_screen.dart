import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:finalprojectadmin/core/model/order_model.dart';
import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/features/user_orders/presentation/bloc/ordersection_bloc.dart';
import 'package:finalprojectadmin/features/user_orders/presentation/screens/order_details_screen.dart';

class AllOrderScreen extends StatelessWidget {
  const AllOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> productModels = [];
    List<OrderModel> orderModels = [];

    return BlocProvider(
      create: (context) => OrdersectionBloc()..add(FetchAllOrderEvent()),
      child: BlocConsumer<OrdersectionBloc, OrdersectionState>(
        listener: (context, state) {
          if (state is AllOrdersFetchedState) {
            productModels = state.products;
            orderModels = state.orders;
          } else if (state is NavigatedToPageState) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(
                  order: state.order,
                  product: state.product,
                ),
              ),
            )
                .then((_) {
              context.read<OrdersectionBloc>().add(FetchAllOrderEvent());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey.shade900,
              title: const Text(
                'User Orders',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: state is LoadingState
                ? _buildShimmerEffect(context)
                : state is AllOrdersFetchedState
                    ? _buildOrderList(context, productModels, orderModels)
                    : const Center(child: Text('No Orders Found')),
          );
        },
      ),
    );
  }

  Widget _buildOrderList(
    BuildContext context,
    List<ProductModel> productModels,
    List<OrderModel> orderModels,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.read<OrdersectionBloc>().add(
                  NavigatedToOrderDetailedPage(
                    order: orderModels[index],
                    product: productModels[index],
                  ),
                );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade800, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(productModels[index].imagepath[0]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: getStatusColor(
                                  trackOrder(orderModels[index])),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              trackOrder(orderModels[index]),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          kheight10,
                          Text(
                            'Consumer: ${orderModels[index].address[0]}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Product: ${productModels[index].name}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Price: ₹${orderModels[index].price}',
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => kheight20,
        itemCount: orderModels.length,
      ),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ListView.separated(
      itemCount: 5, // Display a placeholder for 5 items
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.black,
          highlightColor: Colors.grey,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: screenWidth * 0.3,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 15,
                          width: screenWidth * 0.5,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 15,
                          width: screenWidth * 0.4,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.blue;
      case 'Packed':
        return Colors.orange;
      case 'Shipped':
        return Colors.purple;
      case 'Out for Delivery':
        return Colors.teal;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String trackOrder(OrderModel model) {
    if (model.cancelled == true) {
      return 'Cancelled';
    } else if (model.confirmed == true && model.packed == false) {
      return 'Confirmed';
    } else if (model.packed == true && model.shipped == false) {
      return 'Packed';
    } else if (model.shipped == true && model.outofdelivery == false) {
      return 'Shipped';
    } else if (model.outofdelivery == true && model.completed == false) {
      return 'Out for Delivery';
    } else if (model.completed == true) {
      return 'Completed';
    } else {
      return 'Not Available';
    }
  }
}
