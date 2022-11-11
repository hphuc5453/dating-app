import 'package:flutter/material.dart';

class DatingUser extends StatefulWidget {
  const DatingUser({Key? key}) : super(key: key);

  @override
  State<DatingUser> createState() => _DatingUserState();
}

class _DatingUserState extends State<DatingUser> with SingleTickerProviderStateMixin {

  List<Widget> listData = [];
  TabController? tabController;

  List<Widget> _initData() {
    for (int i = 0; i < 10; i++) {
      listData.add(ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset('assets/images/girl_user.jpg', fit: BoxFit.cover,),));
    }
    return listData;
  }

  @override
  void initState() {
    _initData();
    tabController = TabController(length: listData.length, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: listData,
    );
  }
}
