import 'package:flutter/material.dart';
import 'package:flutterapp/profile/profile_data.dart';
import 'package:flutterapp/utils/text_utils.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
      alignment: Alignment.bottomCenter,
      height: 80,
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.profile.name}, ${widget.profile.age}",
              style: TextUtils.textProfileInfoTitle,
            ),
            Text(
              widget.profile.description,
              style: TextUtils.textProfileInfoDescription,
            ),
          ],
        ),
      ),
    );
  }
}
