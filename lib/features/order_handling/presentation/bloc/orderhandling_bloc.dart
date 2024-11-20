import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalprojectadmin/core/model/order_model.dart';

part 'orderhandling_event.dart';
part 'orderhandling_state.dart';

class OrderhandlingBloc extends Bloc<OrderhandlingEvent, OrderhandlingState> {
  OrderhandlingBloc() : super(OrderhandlingInitial()) {
    on<OrderhandlingEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchingAllOrdersEvent>((event, emit) async {
      emit(LoadingState());
      var orders = await fetchUserOrders();
      print(orders);
      emit(AllOrdersFetchedState(ordermodels: orders));
    });

    on<OrderUpdatingEvent>((event, emit) async {
      emit(LoadingState());
      String field = fieldSelector(event.orderstate);
      updateFieldByOrderId(event.ordermodel.orderid!, field, true);
    });
  }
}

Future<List<OrderModel>> fetchUserOrders() async {
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

Future<void> updateFieldByOrderId(
    String orderId, String fieldName, dynamic newValue) async {
  try {
    // Query the 'orders' collection for a document with the specific 'orderid'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderid', isEqualTo: orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;

      await docRef.update({fieldName: newValue});

      print(
          "$fieldName updated successfully to $newValue for order ID: $orderId");
    } else {
      print("No document found with orderid: $orderId");
    }
  } catch (e) {
    print("Error updating $fieldName for orderid $orderId: $e");
  }
}

String fieldSelector(String orderstate) {
  if (orderstate == 'confirmed') {
    return 'packed';
  } else if (orderstate == 'packed') {
    return 'shipped';
  } else if (orderstate == 'shipped') {
    return 'outofdelivery';
  } else {
    return 'completed';
  }
}
