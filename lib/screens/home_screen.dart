import 'package:flutter/material.dart';
import 'package:productos_app_flutter/models/product.dart';
import 'package:productos_app_flutter/screens/screens.dart';
import 'package:productos_app_flutter/services/services.dart';
import 'package:productos_app_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final products = productsService.products;
    if (productsService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: const Icon(Icons.login_rounded))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: products.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              productsService.selectedProduct = products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
            child: ProductCard(
              product: products[index],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productsService.selectedProduct =
              Product(available: true, name: '', price: 0.0);
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
