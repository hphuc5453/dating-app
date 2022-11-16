import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterapp/extensions/extensions.dart';
import '../constants/app_constants.dart';
import '../utils/text_utils.dart';

class HeaderBar extends StatefulWidget {
  HeaderBar({Key? key,required this.isDatingSelected, required this.isGamesSelected, required this.isChatSelected, required this.listener}) : super(key: key);

  bool isDatingSelected = false;
  bool isGamesSelected = false;
  bool isChatSelected = false;
  IHeaderBarListener listener;

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

abstract class IHeaderBarListener {
  void onTabHeaderChanged(HeaderBarType type);
}

enum HeaderBarType { dating, games, chat }

class _HeaderBarState extends State<HeaderBar> {


  void _onTabHeaderClick(HeaderBarType type) {
    widget.listener.onTabHeaderChanged(type);
  }

  Widget textOnHeaderBar(String text, HeaderBarType type, bool isSelected) {
    if (isSelected) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: TextButton(
          onPressed: () {
            _onTabHeaderClick(type);
          },
          child: Text(text, style: TextUtils.textHeaderActive),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: TextButton(
          onPressed: () {
            _onTabHeaderClick(type);
          },
          child: Text(text, style: TextUtils.textHeaderDefault),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 46, left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textOnHeaderBar(
                    'Dating', HeaderBarType.dating, widget.isDatingSelected),
                textOnHeaderBar('Games', HeaderBarType.games, widget.isGamesSelected),
                textOnHeaderBar('Chats', HeaderBarType.chat, widget.isChatSelected),
              ],
            ),
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: HexColor.fromHex("#ff7d5f"),
                          shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        'assets/images/ic_avatar_default.svg',
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        color: Colors.deepOrangeAccent,
                        shape: BoxShape.circle),
                    child: const Text(
                      '3',
                      style: TextStyle(
                          fontFamily: AppConstants.fontFiraSan,
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
