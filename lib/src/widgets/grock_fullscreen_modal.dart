import 'package:flutter/material.dart';

class GrockFullScreenModal extends ModalRoute {
  GrockFullScreenModal({
    required this.builder,
    this.isSlideTransition = true,
    this.isScaleTransition = false,
    this.isFadeTranssition = true,
    this.isRotateTransition = false,
    this.scaleAlignment = Alignment.topCenter,
    this.slideTransitionType = SlideTransitionType.fromTop,
    this.openDuration = const Duration(milliseconds: 500),
    this.isOpaque = false,
    this.isBarrierDismissible = false,
    this.barrierColorValue = Colors.black54,
    this.barrierLabelValue,
    this.isMaintainState = true,
  });
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) builder;
  final SlideTransitionType slideTransitionType;
  final bool isSlideTransition;
  final bool isScaleTransition;
  final bool isFadeTranssition;
  final bool isRotateTransition;
  final Alignment scaleAlignment;
  final Duration openDuration;
  final bool isOpaque;
  final bool isBarrierDismissible;
  final Color barrierColorValue;
  final String? barrierLabelValue;
  final bool isMaintainState;

  @override
  Duration get transitionDuration => openDuration;

  @override
  bool get opaque => isOpaque;

  @override
  bool get barrierDismissible => isBarrierDismissible;

  @override
  Color get barrierColor => barrierColorValue;

  @override
  String? get barrierLabel => barrierLabelValue;

  @override
  bool get maintainState => isMaintainState;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return RotationTransition(
      turns: isRotateTransition ? animation : const AlwaysStoppedAnimation(0.0),
      child: FadeTransition(
        opacity:
            isFadeTranssition ? animation : const AlwaysStoppedAnimation(1.0),
        child: SlideTransition(
          position: isSlideTransition
              ? Tween<Offset>(
                  begin: slideTransitionType.offset,
                  end: Offset.zero,
                ).animate(animation)
              : const AlwaysStoppedAnimation(Offset.zero),
          child: ScaleTransition(
            scale: isScaleTransition ? animation : AlwaysStoppedAnimation(1.0),
            alignment: scaleAlignment,
            child: child,
          ),
        ),
      ),
    );
  }
}

enum SlideTransitionType {
  fromTop(Offset(0, -1)),
  fromBottom(Offset(0, 1)),
  fromLeft(Offset(-1, 0)),
  fromRight(Offset(1, 0)),
  fromTopLeft(Offset(-1, -1)),
  fromTopRight(Offset(1, -1)),
  fromBottomLeft(Offset(-1, 1)),
  fromBottomRight(Offset(1, 1));

  final Offset offset;
  const SlideTransitionType(this.offset);
}
