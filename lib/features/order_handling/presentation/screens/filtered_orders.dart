import 'package:finalprojectadmin/core/model/order_model.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/features/order_handling/presentation/bloc/orderhandling_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredOrders extends StatelessWidget {
  const FilteredOrders(
      {super.key, required this.model, required this.orderstatus});
  final List<OrderModel> model;
  final String orderstatus;

  String buttontext(String orderstatus) {
    if (orderstatus == 'confirmed') {
      return 'Mark it As Packed';
    } else if (orderstatus == 'packed') {
      return 'Mark it As Shipped';
    } else if (orderstatus == 'shipped') {
      return 'Mark it As Delivery';
    } else {
      return 'Mark it As Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    var button = buttontext(orderstatus);
    return BlocProvider(
      create: (context) => OrderhandlingBloc(),
      child: BlocConsumer<OrderhandlingBloc, OrderhandlingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    kheight10,
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => Container(
                                // height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Customer Name : ${model[index].address[0]}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'Order ID : ${model[index].orderid}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'Product ID : ${model[index].productid}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'Product Qty : ${model[index].count}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'Booked Date : ${model[index].date}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'Booked Time : ${model[index].time}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const Text(
                                        'Payment Mode : Wallet',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Order Status : $orderstatus',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                context
                                                    .read<OrderhandlingBloc>()
                                                    .add(OrderUpdatingEvent(
                                                        ordermodel:
                                                            model[index],
                                                        orderstate:
                                                            orderstatus));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                width: 90,
                                                child: Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    button,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => kheight20,
                          itemCount: model.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
