import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../models/sandwich.dart';
import '../models/extra.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> carouselImages = [
    'assets/xburguer.jpg',
    'assets/burger2.jpg',
    'assets/xbacon.jpg',
    'assets/fries.jpg',
  ];

  final List<Map<String, String>> products = [
    {"name": "X Burguer", "price": "5.00", "image": "assets/xburguer.jpg"},
    {"name": "X Bacon", "price": "7.00", "image": "assets/xbacon.jpg"},
    {"name": "X Egg", "price": "4.50", "image": "assets/xegg.jpg"},
  ];

  final List<Map<String, String>> extras = [
    {"name": "Fries", "price": "2.00", "image": "assets/fries.jpg"},
    {"name": "Soft drink", "price": "2.50", "image": "assets/soft_drink.jpg"},
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < carouselImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bom Hamburguer\'s',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD5C4A1), // Cor bege pastel para o título
          ),
        ),
        backgroundColor: Color(0xFF1C1B1B), // Cor de fundo preto ou marrom escuro
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Substituindo o carrossel com PageView
            Container(
              height: 200.0, // Altura do carrossel
              child: PageView.builder(
                controller: _pageController,
                itemCount: carouselImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        carouselImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Image not found'));
                        },
                      ),
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sandwiches',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD5C4A1), // Cor bege pastel para o texto
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 4,
                  color: Color(0xFF2C2C2C), // Fundo cinza claro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.asset(
                            product['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text('Image not found'));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD5C4A1), // Cor bege pastel para o nome do produto
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${product['price']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD5C4A1), // Cor bege pastel para o botão
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            final sandwich = Sandwich(
                              name: product['name']!,
                              price: double.parse(product['price']!),
                            );
                            if (cartProvider.selectedSandwich != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Você já adicionou um sanduíche ao carrinho.'),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              cartProvider.addSandwich(sandwich);
                            }
                          },
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.black), // Texto em preto
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Extras',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD5C4A1), // Cor bege pastel para o texto
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemCount: extras.length,
              itemBuilder: (context, index) {
                final extra = extras[index];
                return Card(
                  elevation: 4,
                  color: Color(0xFF2C2C2C), // Fundo cinza claro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.asset(
                            extra['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text('Image not found'));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          extra['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD5C4A1), // Cor bege pastel para o nome do extra
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${extra['price']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD5C4A1), // Cor bege pastel para o botão
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (extra['name'] == 'Fries' && cartProvider.selectedFries != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Você já adicionou uma porção de batatas ao carrinho.'),
                                backgroundColor: Colors.red,
                              ));
                            } else if (extra['name'] == 'Soft drink' && cartProvider.selectedSoftDrink != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Você já adicionou um refrigerante ao carrinho.'),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              final extraItem = Extra(
                                name: extra['name']!,
                                price: double.parse(extra['price']!),
                              );
                              cartProvider.addExtra(extraItem);
                            }
                          },
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.black), // Texto em preto
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD5C4A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: Text(
                'Go to Cart',
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
