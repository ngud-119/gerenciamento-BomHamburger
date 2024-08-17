// lib/screens/sandwich_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sandwich.dart';
import '../models/extra.dart';
import '../providers/cart_provider.dart';

class SandwichListScreen extends StatelessWidget {
  final List<Sandwich> sandwiches = [
    Sandwich(name: 'X Burger', price: 5.00),
    Sandwich(name: 'X Egg', price: 4.50),
    Sandwich(name: 'X Bacon', price: 7.00),
  ];

  final List<Extra> extras = [
    Extra(name: 'Fries', price: 2.00),
    Extra(name: 'Soft drink', price: 2.50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sandwiches & Extras')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sandwiches.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(sandwiches[index].name),
                  subtitle: Text('\$${sandwiches[index].price.toStringAsFixed(2)}'),
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addSandwich(sandwiches[index]);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: extras.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(extras[index].name),
                  subtitle: Text('\$${extras[index].price.toStringAsFixed(2)}'),
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addExtra(extras[index]);
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            child: Text('View Cart'),
          ),
        ],
      ),
    );
  }
}
