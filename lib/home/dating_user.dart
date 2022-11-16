import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterapp/constants/app_constants.dart';
import 'package:flutterapp/home/background_curve_widget.dart';
import 'package:flutterapp/profile/drag_widget.dart';
import 'package:flutterapp/profile/profile_data.dart';
import 'package:flutterapp/profile/profile_empty_card_widget.dart';

import '../extensions/extensions.dart';

class DatingUser extends StatefulWidget {
  const DatingUser({Key? key}) : super(key: key);

  @override
  State<DatingUser> createState() => _DatingUserState();
}

class _DatingUserState extends State<DatingUser>
    with SingleTickerProviderStateMixin {
  List<Profile> listData = [];
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;

  List<Profile> _initData() {
    for (int i = 0; i < 8; i++) {
      listData.add(Profile(
          name: "Galina Rover",
          description: "Waiting for someone to take me out of this place",
          age: 24,
          imageAsset: "assets/images/girl_$i.jpeg"));
    }
    return listData;
  }

  @override
  void initState() {
    _initData();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          listData.removeLast();
        });
        _animationController.reset();
        swipeNotifier.value = Swipe.none;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget createDragWidget(int index, Swipe swipe) {
    if (index == listData.length - 1) {
      return PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
              const Rect.fromLTWH(0, 0, AppConstants.profileCardHeight,
                  AppConstants.profileCardWidth),
              const Size(AppConstants.profileCardHeight,
                  AppConstants.profileCardWidth)),
          end: RelativeRect.fromSize(
              Rect.fromLTWH(
                  swipe != Swipe.none
                      ? swipe == Swipe.left
                          ? -AppConstants.profileCardWidth
                          : AppConstants.profileCardWidth
                      : 0,
                  0,
                  AppConstants.profileCardHeight,
                  AppConstants.profileCardWidth),
              const Size(AppConstants.profileCardHeight,
                  AppConstants.profileCardWidth)),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        )),
        child: RotationTransition(
          turns: Tween<double>(
                  begin: 0,
                  end: swipe != Swipe.none
                      ? swipe == Swipe.left
                          ? -0.1 * 0.3
                          : 0.1 * 0.3
                      : 0.0)
              .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0, 0.4, curve: Curves.easeInOut),
            ),
          ),
          child: DragWidget(
            profile: listData[index],
            index: index,
            swipeNotifier: swipeNotifier,
            animationController: _animationController,
            isLastItem: true,
          ),
        ),
      );
    } else {
      return DragWidget(
        profile: listData[index],
        index: index,
        swipeNotifier: swipeNotifier,
        animationController: _animationController,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: listData.isNotEmpty ? Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: const BackgroundCurveWidget(),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
            child: ValueListenableBuilder(
              valueListenable: swipeNotifier,
              builder: (context, swipe, _) => Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: List.generate(
                  listData.length,
                  (index) => createDragWidget(index, swipe),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: 34, bottom: 12, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: GestureDetector(
                      onTap: () {
                        swipeNotifier.value = Swipe.left;
                        _animationController.forward();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: AppConstants.iconNormalSize,
                        height: AppConstants.iconNormalSize,
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#414c61"),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(26))),
                        child: SvgPicture.asset(
                          'assets/images/ic_close.svg',
                          width: 28,
                          height: 28,
                          color: HexColor.fromHex("#63708c"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      swipeNotifier.value = Swipe.right;
                      _animationController.forward();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: AppConstants.iconNormalSize,
                      height: AppConstants.iconNormalSize,
                      decoration: BoxDecoration(
                          color: HexColor.fromHex("#f2bfcb"),
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(26))),
                      child: SvgPicture.asset(
                        'assets/images/ic_heart.svg',
                        width: 28,
                        height: 28,
                        color: HexColor.fromHex("#ff6286"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return IgnorePointer(
                  child: Container(
                    height: AppConstants.profileCardHeight,
                    width: AppConstants.profileCardWidth * 1 / 3,
                    color: Colors.transparent,
                  ),
                );
              },
              onAccept: (int index) {
                setState(() {
                  listData.removeAt(index);
                });
              },
            ),
          ),
          Positioned(
            right: 0,
            child: DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return IgnorePointer(
                  child: Container(
                    height: AppConstants.profileCardHeight,
                    width: AppConstants.profileCardWidth * 1 / 3,
                    color: Colors.transparent,
                  ),
                );
              },
              onAccept: (int index) {
                setState(() {
                  listData.removeAt(index);
                });
              },
            ),
          ),
        ],
      ) : const ProfileEmptyCard(),
    );
  }
}
