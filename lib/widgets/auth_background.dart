import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(children: [
        const _BackgroundBox(),
        const _HeaderIcon(),
        child,
      ]),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox(
          width: double.maxFinite,
          child: Icon(
            Icons.person_pin,
            color: Colors.white,
            size: 100,
          )),
    );
  }
}

class _BackgroundBox extends StatelessWidget {
  const _BackgroundBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      height: size.height * 0.4,
      decoration: _buildBoxDecoration(),
      child: Stack(children: const [
        Positioned(top: 90, left: 30, child: _Bubble()),
        Positioned(top: 40, left: -30, child: _Bubble()),
        Positioned(top: 40, right: -30, child: _Bubble()),
        Positioned(top: -50, left: -20, child: _Bubble()),
        Positioned(bottom: 60, left: -20, child: _Bubble()),
        Positioned(bottom: 120, right: 100, child: _Bubble()),
        Positioned(bottom: 10, right: 30, child: _Bubble()),
      ]),
    );
  }

  _buildBoxDecoration() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white10),
    );
  }
}
