import 'package:flutter/material.dart';

class ImageRotate extends StatefulWidget {
  const ImageRotate({ Key? key }) : super(key: key);

  @override
  State<ImageRotate> createState() => _ImageRotate();
}
class _ImageRotate extends State<ImageRotate>  with TickerProviderStateMixin {

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =  AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    animationController.repeat();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: RotationTransition(
              child: const FlutterLogo(size: 200),
              turns: animationController,
            )
    );
  }
}