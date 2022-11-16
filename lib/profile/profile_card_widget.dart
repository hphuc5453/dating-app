import 'package:flutter/material.dart';
import 'package:flutterapp/profile/profile_data.dart';
import 'package:flutterapp/profile/profile_info_widget.dart';

import '../constants/app_constants.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
    required this.profile,
  }) : super(key: key);
  final Profile profile;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppConstants.profileCardWidth,
        height: AppConstants.profileCardHeight,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  widget.profile.imageAsset,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProfileInfo(
                profile: widget.profile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
