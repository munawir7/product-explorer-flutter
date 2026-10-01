
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/product_local_data_source.dart';
import 'data/repositories/product_reposetories_impl.dart';
import 'domain/repositories/product_repositories.dart';
import 'domain/usecases/get_products.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/providers/product_provider.dart';
import 'presentation/providers/cart_provider.dart';

void main() {
  // ----------------------------------------------------------
  // LOCAL DATA SOURCE
  // ----------------------------------------------------------

  final ProductLocalDataSource localDataSource =
      ProductLocalDataSource();

  // ----------------------------------------------------------
  // REPOSITORY
  // ----------------------------------------------------------

  final ProductRepository repository =
      ProductRepositoryImpl(localDataSource);

  // ----------------------------------------------------------
  // USE CASE
  // ----------------------------------------------------------

  final GetProducts getProducts =
      GetProducts(repository);

  // ----------------------------------------------------------
  // RUN APP
  // ----------------------------------------------------------

  runApp(
    MultiProvider(
      providers: [
        // Product provider
        ChangeNotifierProvider<ProductProvider>(
          create: (_) =>
              ProductProvider(getProducts)
                ..loadProducts(),
        ),

        // Cart provider
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// ============================================================
// APP
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Explorer',

      theme: ThemeData(
        useMaterial3: true,
      ),

      home: const HomePage(),
    );
  }
}

