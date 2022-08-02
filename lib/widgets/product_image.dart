import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: _buildBoxDecoration(),
      width: double.maxFinite,
      height: 450,
      child: const FadeInImage(
        placeholder: AssetImage('assets/no-image.png'),
        image: NetworkImage('https://via.placeholder.com/400x300'),
        fit: BoxFit.cover,
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(0, 5))
          ]);
}
