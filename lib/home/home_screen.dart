import 'package:flutter/material.dart';
import 'package:flutterapp/home/dating_screen.dart';
import 'package:flutterapp/home/header_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, IHeaderBarListener {
  TabController? tabController;
  final int maxTabCount = 3;
  final List<Widget> listData = [];
  bool isDatingSelected = true;
  bool isGamesSelected = false;
  bool isChatSelected = false;

  void _updateUIForTab() {
    if (tabController == null) return;
    setState(() {
      switch (tabController?.index) {
        case 0:
          {
            isDatingSelected = true;
            isGamesSelected = false;
            isChatSelected = false;
            break;
          }
        case 1:
          {
            isDatingSelected = false;
            isGamesSelected = true;
            isChatSelected = false;
            break;
          }
        case 2:
          {
            isDatingSelected = false;
            isGamesSelected = false;
            isChatSelected = true;
            break;
          }
      }
    });
  }

  @override
  void initState() {
    tabController = TabController(length: maxTabCount, vsync: this);
    tabController?.addListener(_updateUIForTab);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HeaderBar(
            isDatingSelected: isDatingSelected,
            isGamesSelected: isGamesSelected,
            isChatSelected: isChatSelected,
            listener: this,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: _initData(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _initData() {
    listData.add(DatingScreen());
    listData.add(Text('dgdsgsgkdjsg'));
    listData.add(Text('dgdsgsgkdjsg'));
    return listData;
  }

  @override
  void onTabHeaderChanged(HeaderBarType type) {
    setState(() {
      switch (type) {
        case HeaderBarType.dating:
          {
            tabController?.index = 0;
            break;
          }
        case HeaderBarType.games:
          {
            tabController?.index = 1;
            break;
          }
        case HeaderBarType.chat:
          {
            tabController?.index = 2;
            break;
          }
      }
    });
  }
}
