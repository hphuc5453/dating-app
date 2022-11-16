import 'package:flutter/material.dart';

class BackgroundCurveWidget extends StatelessWidget {
  const BackgroundCurveWidget({Key? key, this.isTop = true}) : super(key: key);

  final bool isTop;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300 ,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: isTop ? const BorderRadius.only(
            topLeft: Radius.circular(64),
            topRight: Radius.circular(64),
          ) : const BorderRadius.only(
            bottomLeft: Radius.circular(64),
            bottomRight: Radius.circular(64),
          ),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF7F6FF7), Color(0xFF351E69)],
        ),
      ),
    );
  }
}
