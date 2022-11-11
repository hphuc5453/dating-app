import 'package:flutter/cupertino.dart';
import 'package:flutterapp/profile/profile_data.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}