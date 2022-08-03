// ignore_for_file: unnecessary_const

import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
        decoration: _buildBoxDecoration(),
        width: double.maxFinite,
        height: 450,
        child: getImage(url));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(45),
              topRight: const Radius.circular(45)),
          boxShadow: const [
            const BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(0, 5))
          ]);

  Widget getImage(String? picture) {
    if (picture == null) {
      return Image.asset(
        'assets/no-image.png',
        fit: BoxFit.cover,
      );
    }

    if (picture.startsWith('http')) {
      return Opacity(
        opacity: 0.9,
        child: FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.fitWidth,
        ),
      );
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
