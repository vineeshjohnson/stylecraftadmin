import 'package:finalprojectadmin/core/model/order_model.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/normal_button.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/title_text.dart';
import 'package:finalprojectadmin/features/order_handling/presentation/bloc/orderhandling_bloc.dart';
import 'package:finalprojectadmin/features/order_handling/presentation/screens/filtered_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfOrders extends StatelessWidget {
  const ListOfOrders({super.key});

  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    List<OrderModel> models = [];
    return BlocProvider(
      create: (context) => OrderhandlingBloc()..add(FetchingAllOrdersEvent()),
      child: BlocConsumer<OrderhandlingBloc, OrderhandlingState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isloading = true;
          } else {
            if (state is AllOrdersFetchedState) {
              models = state.ordermodels;
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const TitleText(
                    title: 'Hanlde Orders From Here',
                  ),
                  kheight20,
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Below you can see all the orders with its current state.\nUpdate order state if any progress happened.',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  kheight20,
                  NormalButton(
                      onTap: () {
                        List<OrderModel> filteredmodels = [];
                        for (int i = 0; i < models.length; i++) {
                          if (models[i].confirmed == true &&
                              models[i].packed == false) {
                            filteredmodels.add(models[i]);
                          }
                        }
                        print(filteredmodels);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilteredOrders(
                                  model: filteredmodels,
                                  orderstatus: 'confirmed',
                                )));
                      },
                      buttonTxt: 'Confirmed Orders',
                      backGroundColor: Colors.black,
                      textColor: Colors.white),
                  kheight20,
                  NormalButton(
                      onTap: () {
                        List<OrderModel> filteredmodels = [];
                        for (int i = 0; i < models.length; i++) {
                          if (models[i].packed == true &&
                              models[i].shipped == false) {
                            filteredmodels.add(models[i]);
                          }
                        }
                        print(filteredmodels);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilteredOrders(
                                  model: filteredmodels,
                                  orderstatus: 'packed',
                                )));
                      },
                      buttonTxt: 'Packed Orders',
                      backGroundColor: Colors.black,
                      textColor: Colors.white),
                  kheight20,
                  NormalButton(
                      onTap: () {
                        List<OrderModel> filteredmodels = [];
                        for (int i = 0; i < models.length; i++) {
                          if (models[i].shipped == true &&
                              models[i].outofdelivery == false) {
                            filteredmodels.add(models[i]);
                          }
                        }
                        print(filteredmodels);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilteredOrders(
                                  model: filteredmodels,
                                  orderstatus: 'shipped',
                                )));
                      },
                      buttonTxt: 'Shipped Orders',
                      backGroundColor: Colors.black,
                      textColor: Colors.white),
                  kheight20,
                  NormalButton(
                      onTap: () {
                        List<OrderModel> filteredmodels = [];
                        for (int i = 0; i < models.length; i++) {
                          if (models[i].outofdelivery == true &&
                              models[i].completed == false) {
                            filteredmodels.add(models[i]);
                          }
                        }
                        print(filteredmodels);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilteredOrders(
                                  model: filteredmodels,
                                  orderstatus: 'outofdelivery',
                                )));
                      },
                      buttonTxt: 'Delivered Orders',
                      backGroundColor: Colors.black,
                      textColor: Colors.white),
                  kheight20,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
