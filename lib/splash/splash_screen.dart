import 'package:flutter/material.dart';
import 'package:flutterapp/extensions/extensions.dart';
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
  final List<String> listImages = [
    'assets/images/splash_1.svg',
    'assets/images/splash_2.svg',
    'assets/images/splash_3.svg'
  ];
  final List<String> listTitle = [
    'Find Your Special Someone',
    'More Profile, More Dates',
    'Interact Around The World'
  ];
  final List<String> listDescription = [
    'With our new exiting features',
    'Connecting you with more profiles',
    'Send direct message to your matches'
  ];
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
        (router) => false);
  }

  void _updateUIForTab() {
    if (tabController == null) return;
    setState(() {
      if (tabController?.index == maxTabCount - 1) {
        skipOrGotItText = 'Get started';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
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
                            backgroundColor: HexColor.fromHex("#ff506b")),
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
      ),
    );
  }
}
