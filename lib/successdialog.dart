import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:animated_check/animated_check.dart';

class SuccessDialog extends StatefulWidget {
  const SuccessDialog({Key key}) : super(key: key);

  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog>
    with AfterLayoutMixin, TickerProviderStateMixin {
  bool isLoading = true;
  AnimationController _animationController;
  Animation<double> _animation;
  double initialValue = 0;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        padding: EdgeInsets.all(30),
        child: isLoading
            ? SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  size: 100,
                  spinnerMode: true,
                  customWidths:
                      CustomSliderWidths(trackWidth: 10, progressBarWidth: 10),
                  customColors: CustomSliderColors(
                    hideShadow: true,
                    dotColor: Colors.transparent,
                    trackColor: Color.fromRGBO(254, 228, 215, 1),
                    progressBarColor: Color.fromRGBO(216, 116, 85, 1),
                  ),
                ),
              )
            : Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Color.fromRGBO(254, 228, 215, 1), width: 5)),
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedCheck(
                    progress: _animation,
                    size: 100,
                    strokeWidth: 6,
                    color: Color.fromRGBO(216, 116, 85, 1),
                  ),
                )));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        initialValue = 100;
      });
      _animationController.forward();
    });
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pop(true);
    });
  }
}
