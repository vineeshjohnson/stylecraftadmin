import 'package:finalprojectadmin/core/model/order_model.dart';
import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:finalprojectadmin/features/user_orders/presentation/bloc/ordersection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;
  final ProductModel product;

  const OrderDetailsScreen({
    Key? key,
    required this.order,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    return BlocProvider(
      create: (context) => OrdersectionBloc(),
      child: BlocConsumer<OrdersectionBloc, OrdersectionState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isloading = true;
          } else if (state is OrderUpdatedState) {
            Navigator.of(context).pop();
            context.read<OrdersectionBloc>().add(FetchAllOrderEvent());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Order Details',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Status Section
                    _sectionTitle("Order Status"),
                    _statusTimeline(order),
                    Divider(),

                    // Product Details Section
                    _sectionTitle("Product Details"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(product.imagepath.isNotEmpty
                                  ? product.imagepath[0]
                                  : 'https://via.placeholder.com/150'),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _detailRow("Name", product.name),
                              _detailRow("Category", product.category),
                              _detailRow("Brand", product.brand),
                              _detailRow("Price", "₹${product.price}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),

                    // Order Details Section
                    _sectionTitle("Order Details"),
                    _detailRow("Order ID", order.orderid ?? "N/A"),
                    _detailRow("Order Date", order.date),
                    _detailRow("Order Time", order.time),
                    _detailRow("Quantity", order.count.toString()),
                    _detailRow("Total Price", "₹${order.price}"),
                    Divider(),

                    // Address Section
                    _sectionTitle("Delivery Address"),
                    _addressSection(order.address),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(order, () {
              context.read<OrdersectionBloc>().add(OrderHandlingEvent(
                  order: order,
                  product: product,
                  orderstate: orderstate(order)));
            }, isloading),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      OrderModel order, VoidCallback action, bool isloading) {
    if (order.completed == true) {
      return _statusContainer("Order Completed", Colors.green);
    } else if (order.cancelled == true) {
      return _statusContainer("Order Cancelled", Colors.red);
    } else {
      return BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: isloading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                  ),
                  onPressed: action,
                  child: Text(
                    _getButtonText(order),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
        ),
      );
    }
  }

  Widget _statusContainer(
    String message,
    Color color,
  ) {
    return BottomAppBar(
      color: Colors.white,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        color: color.withOpacity(0.1),
        child: Text(
          message,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _statusTimeline(OrderModel order) {
    final steps = [
      "Confirmed",
      "Packed",
      "Shipped",
      "Out for Delivery",
      "Completed",
    ];

    final currentStatus = [
      order.confirmed ?? false,
      order.packed,
      order.shipped ?? false,
      order.outofdelivery ?? false,
      order.completed ?? false,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Status Icon
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: currentStatus[i] ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                  color: currentStatus[i] ? Colors.blue : Colors.white,
                ),
                child: Icon(
                  currentStatus[i] ? Icons.check : Icons.circle_outlined,
                  color: currentStatus[i] ? Colors.white : Colors.grey,
                  size: 18,
                ),
              ),
              SizedBox(width: 8),
              // Step Title
              Text(
                steps[i],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: currentStatus[i] ? Colors.blue : Colors.grey[600],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Container(
                width: 2,
                height: 30,
                color: currentStatus[i] ? Colors.blue : Colors.grey[300],
              ),
            ),
        ]
      ],
    );
  }

  Widget _addressSection(List<dynamic>? address) {
    if (address == null || address.isEmpty) {
      return Text(
        "No Address Provided",
        style: TextStyle(fontSize: 16, color: Colors.red),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow("Name", address[0]), // Name
        _detailRow("Phone", address[1]), // Phone number
        for (int i = 3; i < address.length; i++)
          Text(
            address[i],
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText(OrderModel order) {
    if (order.confirmed == true && order.packed == false) {
      return "Approve to Packing";
    } else if (order.packed == true && order.shipped == false) {
      return "Approve to Shipping";
    } else if (order.shipped == true && order.outofdelivery == false) {
      return "Approve to Out for Delivery";
    } else if (order.outofdelivery == true && order.completed == false) {
      return "Approve to Completed";
    } else {
      return "Not Available";
    }
  }
}

String orderstate(OrderModel order) {
  if (order.confirmed == true && order.packed == false) {
    return 'Confirmed';
  } else if (order.packed == true && order.shipped == false) {
    return 'Packed';
  } else if (order.shipped == true && order.outofdelivery == false) {
    return 'Shipped';
  } else if (order.outofdelivery == true && order.completed == false) {
    return 'Out For Delivery';
  } else if (order.completed == true) {
    return 'Completed';
  } else {
    return '';
  }
}
