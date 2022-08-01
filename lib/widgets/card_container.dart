import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(20.0),
      width: double.maxFinite,
      decoration: _buildBoxDecoration(),
      child: child,
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 15, offset: Offset(0, 5))
          ]);
}
