import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';  // Import DevicePreview
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/payment_screen.dart';  // Import PaymentScreen
import 'providers/cart_provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,  // Ativar o DevicePreview apenas no modo de debug
      builder: (context) => MyApp(), // Iniciar o app com o DevicePreview
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Bom Hamburguer',
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Color(0xFF1C1B1B),  // Fundo marrom escuro
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 36,
              color: Color(0xFFD5C4A1),
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 18,
              color: Color(0xFFD5C4A1),
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 16,
              color: Color(0xFFD5C4A1),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF1C1B1B),  // Cor do fundo da AppBar
            elevation: 0,
            titleTextStyle: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 24,
              color: Color(0xFFD5C4A1),
              fontWeight: FontWeight.bold,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1C1B1B),  // Cor de fundo do botão
              foregroundColor: Color(0xFFD5C4A1),  // Cor do texto do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        home: HomeScreen(),
        routes: {
          '/cart': (context) => CartScreen(),
          '/payment': (context) => PaymentScreen(),  // Adicionar a rota para PaymentScreen
        },
        locale: DevicePreview.locale(context), // Adicionar suporte a DevicePreview
        builder: DevicePreview.appBuilder, // Constrói o app com DevicePreview
      ),
    );
  }
}
