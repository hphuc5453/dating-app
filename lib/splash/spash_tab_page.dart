import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_constants.dart';
import '../extensions/extensions.dart';

class SplashTabPage extends StatelessWidget {
  const SplashTabPage(
      {Key? key,
      required this.imageAssets,
      required this.title,
      required this.description})
      : super(key: key);

  final String imageAssets;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            imageAssets,
            alignment: Alignment.topCenter,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontFamily: AppConstants.fontFiraSan,
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontFamily: AppConstants.fontFiraSan,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: HexColor.fromHex("#78787a")),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
