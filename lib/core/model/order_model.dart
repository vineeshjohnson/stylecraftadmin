import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final List<dynamic> address;
  final String uid;
  final String productid;
  final String date;
  final String time;
  final int price;
  final String size;
  final int count;
  final bool? cashondelivery;
  final bool? walletpayment;
  final bool? onlinepayment;
  final bool? confirmed;
  final bool packed;
  final bool? shipped;
  final bool? outofdelivery;
  final bool? completed;
  final bool? cancelled;
  final String? orderid;
  final String? cancelreason;
  final String? packeddate;
  final String? shippeddate;
  final String? outfordeliverydate;
  final String? completeddate;
  final String? estimatedeliverydate;
  final String? cancelleddate;

  OrderModel(
      {required this.size,
      this.cashondelivery,
      this.walletpayment,
      this.onlinepayment,
      this.confirmed,
      required this.packed,
      this.shipped,
      this.outofdelivery,
      this.completed,
      this.orderid,
      this.cancelled,
      required this.uid,
      required this.productid,
      required this.date,
      required this.time,
      required this.price,
      required this.count,
      required this.address,
      this.cancelreason,
      this.cancelleddate,
      this.completeddate,
      this.estimatedeliverydate,
      this.outfordeliverydate,
      this.packeddate,
      this.shippeddate});

  // Factory constructor to create an OrderModel from a Firebase document snapshot
  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      address: List<dynamic>.from(data['address'] ?? []),
      uid: data['uid'] ?? '',
      productid: data['productid'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      price: data['price'] ?? 0,
      count: data['count'] ?? 0,
      cashondelivery: data['cashondelivery'] ?? false,
      walletpayment: data['walletpayment'] ?? false,
      onlinepayment: data['onlinepayment'] ?? false,
      confirmed: data['confirmed'] ?? false,
      packed: data['packed'] ?? false,
      shipped: data['shipped'] ?? false,
      outofdelivery: data['outofdelivery'] ?? false,
      completed: data['completed'] ?? false,
      cancelled: data['cancelled'] ?? false,
      size: data['size'] ?? '',
      orderid: data['orderid'],
      cancelreason: data['cancelreason'] ?? '',
      packeddate: data['packeddate'],
      shippeddate: data['shippeddate'],
      outfordeliverydate: data['outfordeliverydate'],
      completeddate: data['completeddate'],
      estimatedeliverydate: data['estimatedeliverydate'],
      cancelleddate: data['cancelleddate'],
    );
  }
}
