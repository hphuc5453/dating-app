import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterapp/constants/app_constants.dart';
import 'package:flutterapp/utils/text_utils.dart';

class ProfileEmptyCard extends StatefulWidget {
  const ProfileEmptyCard({Key? key}) : super(key: key);

  @override
  State<ProfileEmptyCard> createState() => _ProfileEmptyCardState();
}

class _ProfileEmptyCardState extends State<ProfileEmptyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/data_empty.svg',
                      alignment: Alignment.topCenter,
                      height: AppConstants.illustrationNormalSize,
                      width: AppConstants.illustrationNormalSize),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Empty list',
                      style: TextUtils.textProfileInfoTitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                    child: Text(
                      'You have no friend suggestion at the moment.',
                      style: TextUtils.textProfileInfoDescription,
                      textAlign: TextAlign.center,
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
