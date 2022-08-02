import 'package:flutter/material.dart';
import 'package:productos_app_flutter/widgets/input_decoration.dart';
import 'package:productos_app_flutter/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white)),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt,
                          size: 40, color: Colors.white)),
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {},
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.maxFinite,
      decoration: _buildBoxDecoration(),
      child: Form(
        child: Column(children: [
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Nombre:', hintText: 'Nombre del producto'),
          ),
          SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Precio:', hintText: '\$150'),
          ),
          SizedBox(height: 30),
          SwitchListTile.adaptive(
            value: true,
            title: const Text('Disponible'),
            onChanged: (value) {},
          ),
          SizedBox(height: 30),
        ]),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 5), blurRadius: 10),
          ]);
}
