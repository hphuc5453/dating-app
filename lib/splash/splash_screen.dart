import 'package:flutter/material.dart';
import 'package:flutterapp/home/home_screen.dart';
import 'package:flutterapp/splash/spash_tab_page.dart';

import '../constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final int maxTabCount = 3;
  final List<Widget> listData = [];
  final List<String> listImages = ['assets/images/2019.svg', 'assets/images/2020.svg', 'assets/images/2021.svg'];
  final List<String> listTitle = ['Trusted Friends', 'Identity', 'Backup of the capsule shard'];
  final List<String> listDescription = ["'Trusted Friends' is a M-of-N social recovery module that allows users to access their accounts", 'All accounts can have an unlimited number of sub-accounts specified', 'Each capsule have a unique shard which allows the NFT owner to decipher it'];
  var skipOrGotItText = 'Skip';

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: maxTabCount, vsync: this);
    tabController?.addListener(_updateUIForTab);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void _onClickSkipButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (router) => false
    );
  }

  void _updateUIForTab() {
    if (tabController == null) return;
    setState(() {
      if(tabController?.index == maxTabCount - 1) {
        skipOrGotItText = 'Got it';
      } else {
        skipOrGotItText = 'Skip';
      }
    });
  }

  List<Widget> _initData() {
    for (int i = 0; i < maxTabCount; i++) {
      listData.add(SplashTabPage(
        imageAssets: listImages[i],
        title: listTitle[i],
        description: listDescription[i],
      ));
    }
    return listData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: _initData(),
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  alignment: Alignment.center,
                  child: TabPageSelector(
                    controller: tabController,
                    selectedColor: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 24),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                      onPressed: _onClickSkipButton,
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          elevation: 2,
                          backgroundColor: Colors.blueAccent),
                      child: Text(
                        skipOrGotItText,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: AppConstants.fontFiraSan,
                            color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
