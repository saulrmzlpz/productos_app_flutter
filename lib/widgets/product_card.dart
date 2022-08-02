import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

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
        children: const [
          _BackgroundImage(),
          _ProductDetails(),
          Positioned(top: 0, right: 0, child: _PriceTag()),
          Positioned(top: 0, left: 0, child: _NotAvailable())
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
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FittedBox(
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))),
      child: const FittedBox(
          fit: BoxFit.contain,
          child: Text('\$103.99',
              style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 400,
      child: const FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage('https://via.placeholder.com/400x300'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    Key? key,
  }) : super(key: key);

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
          const Text(
            'Disco duro G',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            'Disco duro G',
            style: TextStyle(
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
