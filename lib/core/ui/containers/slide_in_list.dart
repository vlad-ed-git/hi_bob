import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

/// An animated list with slide in animation
class SlideInList extends StatefulWidget {
  final List<dynamic> listItems;
  final Widget Function(int index) itemBuilder;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const SlideInList({
    Key? key,
    required this.listItems,
    required this.itemBuilder,
    this.physics,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  State<SlideInList> createState() => _SlideInListState();
}

class _SlideInListState extends State<SlideInList> {
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        key: _animatedListKey,
        itemCount: widget.listItems.length,
        physics: widget.physics ?? const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: widget.shrinkWrap,
        itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            horizontalOffset: -50.0,
            child: FadeInAnimation(
              child: widget.itemBuilder(index),
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox.shrink();
        },
      ),
    );
  }
}
