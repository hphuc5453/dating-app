import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../extensions/extensions.dart';
import 'dating_user.dart';

class DatingScreen extends StatefulWidget {
  const DatingScreen({Key? key}) : super(key: key);

  @override
  State<DatingScreen> createState() => _DatingScreenState();
}

enum DatingType { dating, location, favorites }

abstract class IDatingTabChangedListener {
  void onTabChange(DatingType type);
}

class _DatingScreenState extends State<DatingScreen> {
  bool isDatingSelected = true;
  bool isLocationSelected = false;
  bool isFavoritesSelected = false;
  late IDatingTabChangedListener listener;

  void _onDatingTypeClick(DatingType type) {
    setState(() {
      switch (type) {
        case DatingType.dating:
          {
            isDatingSelected = true;
            isLocationSelected = false;
            isFavoritesSelected = false;
            break;
          }
        case DatingType.location:
          {
            isDatingSelected = false;
            isLocationSelected = true;
            isFavoritesSelected = false;
            break;
          }
        case DatingType.favorites:
          {
            isDatingSelected = false;
            isLocationSelected = false;
            isFavoritesSelected = true;
            break;
          }
        default:
      }
    });
  }

  Widget datingType(DatingType type, bool isSelected, String image) {
    if (isSelected) {
      return Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: GestureDetector(
          onTap: () {
            _onDatingTypeClick(type);
          },
          child: Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#7f70f7"),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(14))),
            child: SvgPicture.asset(
              image,
              width: 28,
              height: 28,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _onDatingTypeClick(type);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#cbcbe3"),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(14))),
            child: SvgPicture.asset(
              image,
              width: 24,
              height: 24,
              color: HexColor.fromHex("#7f70f7"),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            datingType(DatingType.dating, isDatingSelected,
                'assets/images/ic_dating.svg'),
            datingType(DatingType.location, isLocationSelected,
                'assets/images/ic_location.svg'),
            datingType(DatingType.favorites, isFavoritesSelected,
                'assets/images/ic_favorites.svg'),
          ],
        ),
        Expanded(
          child: DatingUser(),
        ),
      ],
    );
  }
}
