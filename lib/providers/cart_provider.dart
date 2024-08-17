import 'package:flutter/material.dart';
import '../models/sandwich.dart';
import '../models/extra.dart';

class CartProvider with ChangeNotifier {
  Sandwich? _selectedSandwich;
  Extra? _selectedFries;
  Extra? _selectedSoftDrink;

  // Getters para acessar as variáveis privadas
  Sandwich? get selectedSandwich => _selectedSandwich;
  Extra? get selectedFries => _selectedFries;
  Extra? get selectedSoftDrink => _selectedSoftDrink;

  void addSandwich(Sandwich sandwich) {
    _selectedSandwich = sandwich;
    notifyListeners();
  }

  void addExtra(Extra extra) {
    if (extra.name == 'Fries') {
      _selectedFries = extra;
    } else if (extra.name == 'Soft drink') {
      _selectedSoftDrink = extra;
    }
    notifyListeners();
  }

  void removeSandwich() {
    _selectedSandwich = null;
    notifyListeners();
  }

  void removeExtra(String extraName) {
    if (extraName == 'Fries') {
      _selectedFries = null;
    } else if (extraName == 'Soft drink') {
      _selectedSoftDrink = null;
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = _selectedSandwich?.price ?? 0;
    if (_selectedFries != null) total += _selectedFries!.price;
    if (_selectedSoftDrink != null) total += _selectedSoftDrink!.price;

    // Aplicar descontos
    if (_selectedFries != null && _selectedSoftDrink != null) {
      total *= 0.8;  // 20% de desconto
    } else if (_selectedSoftDrink != null) {
      total *= 0.85; // 15% de desconto
    } else if (_selectedFries != null) {
      total *= 0.9;  // 10% de desconto
    }

    return total;
  }

  void clearCart() {
    _selectedSandwich = null;
    _selectedFries = null;
    _selectedSoftDrink = null;
    notifyListeners();
  }

  bool isValidOrder() {
    return _selectedSandwich != null;
  }
}
