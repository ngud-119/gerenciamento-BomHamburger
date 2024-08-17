// lib/models/order.dart

import 'sandwich.dart';
import 'extra.dart';

class Order {
  final Sandwich sandwich;
  final Extra? fries;
  final Extra? softDrink;
  final double totalPrice;

  Order({
    required this.sandwich,
    this.fries,
    this.softDrink,
    required this.totalPrice,
  });
}
