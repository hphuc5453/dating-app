import 'package:flutter/material.dart';
import 'package:flutterapp/profile/profile_card_widget.dart';
import 'package:flutterapp/profile/profile_data.dart';
import 'package:flutterapp/profile/tag_widget.dart';

enum Swipe { left, right, none }

class DragWidget extends StatefulWidget {
  const DragWidget(
      {Key? key,
      required this.profile,
      required this.index,
      required this.swipeNotifier,
      required this.animationController,
      this.isLastItem = false})
      : super(key: key);

  final Profile profile;
  final int index;
  final ValueNotifier<Swipe> swipeNotifier;
  final AnimationController animationController;
  final bool isLastItem;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: widget.index,
      feedback: Material(
        color: Colors.transparent,
        child: ValueListenableBuilder(
          valueListenable: widget.swipeNotifier,
          builder: (context, swipe, _) {
            return RotationTransition(
                turns: swipe != Swipe.none
                    ? swipe == Swipe.left
                        ? const AlwaysStoppedAnimation(-5 / 360)
                        : const AlwaysStoppedAnimation(5 / 360)
                    : const AlwaysStoppedAnimation(0),
                child: Stack(
                  children: [
                    ProfileCard(
                      profile: widget.profile,
                    ),
                    widget.swipeNotifier.value != Swipe.none
                        ? widget.swipeNotifier.value == Swipe.right
                            ? Positioned(
                                top: 40,
                                left: 20,
                                child: Transform.rotate(
                                  angle: 12,
                                  child: TagWidget(
                                    text: 'LIKE',
                                    color: Colors.green[400]!,
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 50,
                                right: 24,
                                child: Transform.rotate(
                                  angle: -12,
                                  child: TagWidget(
                                    text: 'DISLIKE',
                                    color: Colors.red[400]!,
                                  ),
                                ),
                              )
                        : const SizedBox.shrink(),
                  ],
                ));
          },
        ),
      ),
      onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
        // When Draggable widget is dragged right
        if (dragUpdateDetails.delta.dx > 0 &&
            dragUpdateDetails.globalPosition.dx >
                MediaQuery.of(context).size.width / 2) {
          widget.swipeNotifier.value = Swipe.right;
        }
        // When Draggable widget is dragged left
        if (dragUpdateDetails.delta.dx < 0 &&
            dragUpdateDetails.globalPosition.dx <
                MediaQuery.of(context).size.width / 2) {
          widget.swipeNotifier.value = Swipe.left;
        }
      },
      onDragEnd: (drag) {
        widget.swipeNotifier.value = Swipe.none;
      },
      childWhenDragging: Container(
        color: Colors.transparent,
      ),
      child: ValueListenableBuilder(
          valueListenable: widget.swipeNotifier,
          builder: (BuildContext context, Swipe swipe, Widget? child) {
            return Stack(
              children: [
                ProfileCard(
                  profile: widget.profile,
                ),
                widget.swipeNotifier.value != Swipe.none && widget.isLastItem
                    ? widget.swipeNotifier.value == Swipe.right
                        ? Positioned(
                            top: 40,
                            left: 20,
                            child: Transform.rotate(
                              angle: 12,
                              child: TagWidget(
                                text: 'LIKE',
                                color: Colors.green[400]!,
                              ),
                            ),
                          )
                        : Positioned(
                            top: 50,
                            right: 24,
                            child: Transform.rotate(
                              angle: -12,
                              child: TagWidget(
                                text: 'DISLIKE',
                                color: Colors.red[400]!,
                              ),
                            ),
                          )
                    : const SizedBox.shrink(),
              ],
            );
          }),
    );
  }
}
