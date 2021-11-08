import 'package:expandable_view/expandableview.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AmountSelection extends StatelessWidget {
  final ExpandableViewController controller;
  final Function() changeCurrentPage;
  final Function(int) sendAmountToParent;
  var amountNotifier = ValueNotifier(100000);
  AmountSelection(
      {Key key,
      @required this.controller,
      this.changeCurrentPage,
      this.sendAmountToParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableView(
      expandedWidget: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("shivank,how much do you need?",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(113, 132, 145, 1),
                      fontFamily: "note_sans",
                      fontWeight: FontWeight.bold)),
              Container(
                height: 5,
              ),
              Text("move the dial and set any amount you need up to ₹100000",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(113, 132, 145, 0.5),
                      fontFamily: "note_sans",
                      fontWeight: FontWeight.w400)),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: amountNotifier,
                        builder: (ctx, value, widget) {
                          return SleekCircularSlider(
                            min: 0,
                            max: 150000,
                            appearance: CircularSliderAppearance(
                                animationEnabled: false,
                                customWidths: CustomSliderWidths(
                                    trackWidth: 15,
                                    progressBarWidth: 15,
                                    handlerSize: 12),
                                customColors: CustomSliderColors(
                                  hideShadow: true,
                                  dotColor: Color.fromRGBO(40, 32, 30, 1),
                                  trackColor: Color.fromRGBO(254, 228, 215, 1),
                                  progressBarColor:
                                      Color.fromRGBO(216, 116, 85, 1),
                                ),
                                size: 300,
                                startAngle: 270,
                                angleRange: 360),
                            initialValue: amountNotifier.value.toDouble(),
                            onChangeEnd: (value) {
                              onSelectionEnd(value.round());
                            },
                            innerWidget: (double value) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color.fromRGBO(254, 228, 215, 1),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("credit amount",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                157, 157, 157, 1),
                                            fontFamily: "note_sans",
                                            fontWeight: FontWeight.w400)),
                                    Container(
                                      height: 5,
                                    ),
                                    RichText(
                                      key: ValueKey<int>(amountNotifier.value),
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "₹",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromRGBO(
                                                    19, 19, 19, 1),
                                                fontFamily: "note_sans",
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(
                                            text: " ${value.round()}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Color.fromRGBO(
                                                    19, 19, 19, 1),
                                                fontFamily: "note_sans",
                                                fontWeight: FontWeight.w700))
                                      ]),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text("@ 1.04% monthly",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green[300],
                                            fontFamily: "note_sans",
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                          "stash is instant,money will be credited within seconds",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(157, 157, 157, 1),
                              fontFamily: "note_sans",
                              fontWeight: FontWeight.w400))
                    ],
                  )),
            ],
          )),
      collapseWidget: GestureDetector(
        onTap: changeCurrentPage,
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("credit amount",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(113, 132, 145, 0.5),
                              fontFamily: "note_sans",
                              fontWeight: FontWeight.w400)),
                      ValueListenableBuilder(
                          builder: (ctx, value, widget) {
                            return Text("₹$value",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(113, 132, 145, 0.5),
                                    fontFamily: "note_sans",
                                    fontWeight: FontWeight.w600));
                          },
                          valueListenable: amountNotifier)
                    ])),
                IconButton(
                  color: Color.fromRGBO(143, 157, 158, 1),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: changeCurrentPage,
                )
              ],
            )),
      ),
      controller: controller,
    );
  }

  onSelectionEnd(int value) async {
    if (await Vibration.hasVibrator()) {
      if (await Vibration.hasAmplitudeControl()) {
        Vibration.vibrate(amplitude: 1, duration: 50);
      } else {
        Vibration.vibrate(duration: 50);
      }
    }
    if (value < 5000) {
      amountNotifier.value = 5000;
      sendAmountToParent(5000);
    } else if (value % 5000 == 0) {
      amountNotifier.value = value.round();
      sendAmountToParent(value.round());
    } else {
      int roundedfacor = (value.round() / 5000).round();
      amountNotifier.value = roundedfacor * 5000;
      sendAmountToParent(roundedfacor * 5000);
    }
  }
}
