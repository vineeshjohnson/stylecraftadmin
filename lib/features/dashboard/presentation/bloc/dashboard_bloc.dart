import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalprojectadmin/core/model/order_model.dart';
import 'package:finalprojectadmin/core/model/product_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {});
    on<FetchAllOrdersForDashboardEvent>((event, emit) async {
      emit(LoadingState());
      List<OrderModel> orders = await fetchAllOrders();
      List<ProductModel> products = await fetchAllOrderedProducts(orders);
      int completeorders = completedorders(orders);
      int cancelledorders = cancelleddorders(orders);
      int incompletedorders = incompletedorderss(orders);
      int totalmoney = totalturnover(orders);

      emit(AllOrdersFetchedForDashboardState(
          completeorders, cancelledorders, totalmoney, incompletedorders,
          orders: orders, products: products));
    });
  }
}

fetchAllOrders() async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore.collection('orders').get();
    print(querySnapshot.size);
    return querySnapshot.docs
        .map((doc) => OrderModel.fromFirestore(doc))
        .toList();
  } catch (e) {
    print("Error fetching orders: $e");
    return [];
  }
}

fetchAllOrderedProducts(List<OrderModel> orders) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<ProductModel> products = [];

    for (OrderModel order in orders) {
      final docSnapshot =
          await firestore.collection('products').doc(order.productid).get();

      if (docSnapshot.exists) {
        products.add(ProductModel.fromDocument(docSnapshot));
      }
    }
    return products;
  } catch (e) {
    print("Error fetching products: $e");
    return [];
  }
}

int completedorders(List<OrderModel> models) {
  int count = 0;

  for (int i = 0; i < models.length; i++) {
    if (models[i].completed == true) {
      count++;
    }
  }
  return count;
}

int cancelleddorders(List<OrderModel> models) {
  int count = 0;

  for (int i = 0; i < models.length; i++) {
    if (models[i].cancelled == true) {
      count++;
    }
  }
  return count;
}

int incompletedorderss(List<OrderModel> models) {
  int count = 0;

  for (int i = 0; i < models.length; i++) {
    if (models[i].cancelled == false && models[i].completed == false) {
      count++;
    }
  }
  return count;
}

int totalturnover(List<OrderModel> models) {
  List<OrderModel> completedordermodels = [];
  for (int i = 0; i < models.length; i++) {
    if (models[i].completed == true) {
      completedordermodels.add(models[i]);
    }
  }
  int totalturnover = 0;
  for (int i = 0; i < completedordermodels.length; i++) {
    totalturnover = totalturnover + completedordermodels[i].price;
  }
  return totalturnover;
}
