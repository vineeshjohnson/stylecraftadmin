import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalprojectadmin/core/model/order_model.dart';
import 'package:finalprojectadmin/core/model/product_model.dart';
import 'package:intl/intl.dart';

part 'ordersection_event.dart';
part 'ordersection_state.dart';

class OrdersectionBloc extends Bloc<OrdersectionEvent, OrdersectionState> {
  OrdersectionBloc() : super(OrdersectionInitial()) {
    on<OrdersectionEvent>((event, emit) {
    });

    on<FetchAllOrderEvent>((event, emit) async {
      emit(LoadingState());
      List<OrderModel> orders = await fetchAllOrders();
      List<ProductModel> products = await fetchAllOrderedProducts(orders);
      emit(AllOrdersFetchedState(orders: orders, products: products));
    });

    on<OrderHandlingEvent>((event, emit) async {
      emit(LoadingState());
      String field = fieldSelector(event.orderstate);
      bool status =
          await updateFieldByOrderId(event.order.orderid!, field, true);
      emit(OrderUpdatedState(success: status));
    });

    on<NavigatedToOrderDetailedPage>((event, emit) async {
      emit(NavigatedToPageState(
        order: event.order,
        product: event.product,
      ));
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

String fieldSelector(String orderstate) {
  if (orderstate == 'Confirmed') {
    return 'packed';
  } else if (orderstate == 'Packed') {
    return 'shipped';
  } else if (orderstate == 'Shipped') {
    return 'outofdelivery';
  } else if (orderstate == 'Out For Delivery') {
    return 'completed';
  } else {
    return '';
  }
}

String dateselector(String orderstate) {
  if (orderstate == 'packed') {
    return 'packeddate';
  } else if (orderstate == 'shipped') {
    return 'shippeddate';
  } else if (orderstate == 'outofdelivery') {
    return 'outfordeliverydate';
  } else if (orderstate == 'completed') {
    return 'completeddate';
  } else {
    return '';
  }
}

Future<bool> updateFieldByOrderId(
    String orderId, String fieldName, dynamic newValue) async {
  try {
    bool? success;
    var datefield = dateselector(fieldName);
    var date = getTodayDateString();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderid', isEqualTo: orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;

      await docRef.update({fieldName: newValue, datefield: date});
      success = true;
      print(
          "$fieldName updated successfully to $newValue for order ID: $orderId");
      return success;
    } else {
      print("No document found with orderid: $orderId");
      success = false;
      return success;
    }
  } catch (e) {
    print("Error updating $fieldName for orderid $orderId: $e");
    return false;
  }
}

String getTodayDateString() {
  DateTime now = DateTime.now();
  String formattedDate =
      DateFormat('dd-MMMM-yyyy').format(now); // Format as '12-January-2024'
  return formattedDate;
}
