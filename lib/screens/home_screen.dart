import 'package:flutter/material.dart';
import 'package:productos_app_flutter/screens/screens.dart';
import 'package:productos_app_flutter/services/services.dart';
import 'package:productos_app_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final products = productsService.products;
    if (productsService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
