import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app_flutter/providers/product_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:productos_app_flutter/services/services.dart';
import 'package:productos_app_flutter/widgets/input_decoration.dart';
import 'package:productos_app_flutter/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
        create: (context) =>
            ProductFormProvider(productsService.selectedProduct),
        child: _ProductScreenBody(productsService: productsService));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productsService,
  }) : super(key: key);

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productsService.selectedProduct.picture,
                ),
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
                      onPressed: () async {
                        final pickFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery, imageQuality: 25);
                        if (pickFile == null) {
                        } else {
                          productsService
                              .updateSelectedProductImage(pickFile.path);
                        }
                      },
                      icon: const Icon(Icons.camera_alt,
                          size: 40, color: Colors.white)),
                ),
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: productsService.isSaving
            ? null
            : () async {
                if (productForm.isValidForm()) {
                  final String? imageUrl = await productsService.uploadImage();
                  if (imageUrl != null) {
                    productForm.product.picture = imageUrl;
                    log(imageUrl);
                  }
                  await productsService
                      .saveOrCreateProduct(productForm.product);
                }
              },
        child: productsService.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save),
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
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.maxFinite,
      decoration: _buildBoxDecoration(),
      child: Form(
        key: productForm.formKey,
        child: Column(children: [
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: product.name,
            onChanged: (value) => product.name = value,
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return 'El nombre es obligatorio';
              }
              return null;
            }),
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Nombre:', hintText: 'Nombre del producto'),
          ),
          const SizedBox(height: 30),
          TextFormField(
            initialValue: '${product.price}',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            ],
            onChanged: (value) => product.price = double.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Precio:', hintText: '\$150'),
          ),
          const SizedBox(height: 30),
          SwitchListTile.adaptive(
            title: const Text('Disponible'),
            value: product.available,
            onChanged: productForm.updateAvailability,
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
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
