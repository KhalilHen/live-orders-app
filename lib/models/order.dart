import 'package:flutter/material.dart';
import 'package:live_order_apps/models/menu.dart';
import 'package:live_order_apps/models/restaurant.dart';

class Order {
  final int id;
  final String? userId;
  final int restaurantId;

  final num totalAmount;
  // final OrderStatus status;
  final Restaurant? restaurant;
  final DateTime? orderTime;
  final List<MenuItem> items;
  final String customerName;
  Order({
    required this.id,
    this.userId,
    required this.restaurantId,
    required this.totalAmount,
    // required this.status,
    this.restaurant,
    this.orderTime,
    this.items = const [],
    required this.customerName,
  });

  factory Order.fromMap(Map<String, dynamic> data) {
    // Parse items from order_items
    List<MenuItem> items = (data['order_items'] as List?)?.map((itemData) => MenuItem.fromMap(itemData['menu_items'] ?? {})).toList() ?? [];

    return Order(
      id: _parseId(data['id']),
      userId: data['user_id']?.toString(),
      restaurantId: _parseId(data['restaurant_id']),
      totalAmount: _parseAmount(data['total_amount']),
      // status: _parseStatus(data['status']),
      restaurant: data['restaurant'] != null ? Restaurant.fromMap(data['restaurant'] ?? {}) : null,
      orderTime: _parseDateTime(data['order_time']),
      items: items,
      customerName: data['customer_name'] ?? '',
    );
  }

  static int _parseId(dynamic value) {
    if (value == null) return 0;
    return value is int ? value : int.tryParse(value.toString()) ?? 0;
  }

  static num _parseAmount(dynamic value) {
    if (value == null) return 0;
    return value is num ? value : num.tryParse(value.toString()) ?? 0;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    DateTime? dateTime = value is DateTime ? value : DateTime.tryParse(value.toString());
    return dateTime;
  }

  // static OrderStatus _parseStatus(dynamic status) {
  //   if (status == null) return OrderStatus.Unknown;

  //   String statusString = status.toString().toLowerCase();

  //   switch (statusString) {
  //     case 'pending':
  //       return OrderStatus.Pending;
  //     case 'accepted':
  //       return OrderStatus.Accepted;
  //     case 'kitchen':
  //       return OrderStatus.Kitchen;
  //     case 'ready':
  //       return OrderStatus.Ready;
  //     case 'completed':
  //       return OrderStatus.Completed;
  //     case 'cancelled':
  //       return OrderStatus.Cancelled;
  //     case 'rejected':
  //       return OrderStatus.Rejected;
  //     default:
  //       return OrderStatus.Unknown;
  //   }
  // }
}
