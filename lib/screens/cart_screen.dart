import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _nameController = TextEditingController();
  String _customerName = '';
  bool _orderPlaced = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _customerName = _nameController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final hasSandwich = cartProvider.selectedSandwich != null;
    final hasFries = cartProvider.selectedFries != null;
    final hasSoftDrink = cartProvider.selectedSoftDrink != null;

    final double subtotal = (cartProvider.selectedSandwich?.price ?? 0) +
        (cartProvider.selectedFries?.price ?? 0) +
        (cartProvider.selectedSoftDrink?.price ?? 0);

    double discount = 0.0;
    if (hasSandwich && hasFries && hasSoftDrink) {
      discount = subtotal * 0.20; // 20% de desconto
    } else if (hasSandwich && hasSoftDrink) {
      discount = subtotal * 0.15; // 15% de desconto
    } else if (hasSandwich && hasFries) {
      discount = subtotal * 0.10; // 10% de desconto
    }

    final double total = subtotal - discount;
    final bool isCartEmpty = !hasSandwich && !hasFries && !hasSoftDrink;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Color(0xFF1C1B1B),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          if (_orderPlaced)
            Column(
              children: [
                Text(
                  'Pedido de $_customerName concluído com sucesso!',
                  style: TextStyle(color: Colors.green, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Divider(color: Color(0xFFD5C4A1)),
              ],
            ),
          if (hasSandwich && !_orderPlaced)
            _buildCartItem(
              context,
              cartProvider,
              cartProvider.selectedSandwich!.name,
              cartProvider.selectedSandwich!.price,
              onRemove: () => cartProvider.removeSandwich(),
            ),
          if (hasFries && !_orderPlaced)
            _buildCartItem(
              context,
              cartProvider,
              cartProvider.selectedFries!.name,
              cartProvider.selectedFries!.price,
              onRemove: () => cartProvider.removeExtra('Fries'),
            ),
          if (hasSoftDrink && !_orderPlaced)
            _buildCartItem(
              context,
              cartProvider,
              cartProvider.selectedSoftDrink!.name,
              cartProvider.selectedSoftDrink!.price,
              onRemove: () => cartProvider.removeExtra('Soft drink'),
            ),
          if (!_orderPlaced) ...[
            Divider(color: Color(0xFFD5C4A1)),
            ListTile(
              title: Text('Subtotal', style: TextStyle(color: Color(0xFFD5C4A1), fontWeight: FontWeight.bold)),
              subtitle: Text('\$${subtotal.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFD5C4A1))),
            ),
            if (discount > 0)
              ListTile(
                title: Text('Discount', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                subtitle: Text('-\$${discount.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFD5C4A1))),
              ),
            ListTile(
              title: Text('Total', style: TextStyle(color: Color(0xFFD5C4A1), fontWeight: FontWeight.bold)),
              subtitle: Text('\$${total.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFD5C4A1))),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                labelStyle: TextStyle(color: Color(0xFFD5C4A1)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD5C4A1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              style: TextStyle(color: Color(0xFFD5C4A1)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isCartEmpty || _customerName.isEmpty ? Colors.grey : Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: isCartEmpty || _customerName.isEmpty
                  ? null
                  : () {
                      setState(() {
                        _orderPlaced = true;
                        cartProvider.clearCart(); // Limpa o carrinho
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Pedido concluído com sucesso, $_customerName!'),
                        backgroundColor: Colors.green,
                      ));
                    },
              child: Text('Pay Now', style: TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    CartProvider cartProvider,
    String name,
    double price, {
    required VoidCallback onRemove,
  }) {
    return ListTile(
      title: Text(name, style: TextStyle(color: Color(0xFFD5C4A1))),
      subtitle: Text('\$${price.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFD5C4A1))),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle_outline, color: Colors.red),
        onPressed: onRemove,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
