// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:productos_app_flutter/models/models.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: _buildBoxDecoration(),
      margin: const EdgeInsets.only(top: 30, bottom: 50),
      height: 350,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _BackgroundImage(
            picture: product.picture,
          ),
          _ProductDetails(
            name: product.name,
            id: product.id,
          ),
          Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(
                price: product.price,
              )),
          Visibility(
              visible: !product.available,
              child: const Positioned(top: 0, left: 0, child: _NotAvailable()))
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
              color: Colors.black38, offset: Offset(0, 5), blurRadius: 10),
        ]);
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius:
              const BorderRadius.only(bottomRight: const Radius.circular(25))),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Text(
          'No disponible',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({
    Key? key,
    required this.price,
  }) : super(key: key);
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))),
      child: FittedBox(
          fit: BoxFit.contain,
          child: Text('\$$price',
              style: const TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
    this.picture,
  }) : super(key: key);
  final String? picture;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 400,
      child: picture == null
          ? Image(
              image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover,
            )
          : FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(picture!),
              fit: BoxFit.contain,
            ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({Key? key, required this.name, this.id})
      : super(key: key);
  final String name;
  final String? id;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.maxFinite,
      height: 70,
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            id ?? '',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(topRight: Radius.circular(25)));
}
