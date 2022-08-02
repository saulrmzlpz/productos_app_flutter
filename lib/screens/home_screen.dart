import 'package:flutter/material.dart';
import 'package:productos_app_flutter/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'product'),
            child: ProductCard()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
