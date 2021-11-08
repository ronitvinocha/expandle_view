import 'package:expandable_view/expandableview.dart';
import 'package:flutter/material.dart';

class EmiSelection extends StatefulWidget {
  final int amount;
  final ExpandableViewController controller;
  final Function changePage;
  const EmiSelection({Key key, this.amount, this.controller, this.changePage})
      : super(key: key);

  @override
  _EmiSelectionState createState() => _EmiSelectionState();
}

class _EmiSelectionState extends State<EmiSelection> {
  ValueNotifier<int> emiMonthNotifier;
  @override
  void initState() {
    emiMonthNotifier = ValueNotifier(12);
    print(widget.amount);
    super.initState();
  }

  @override
  void dispose() {
    emiMonthNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableView(
      expandedWidget: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color.fromRGBO(20, 21, 32, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("how do you wish to repay?",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(113, 132, 145, 1),
                      fontFamily: "note_sans",
                      fontWeight: FontWeight.bold)),
              Container(
                height: 5,
              ),
              Text("choose one of our recommended plan",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(113, 132, 145, 0.5),
                      fontFamily: "note_sans",
                      fontWeight: FontWeight.w400)),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      getEmiBox(Color.fromRGBO(55, 38, 48, 1), 12),
                      Container(
                        width: 20,
                      ),
                      getEmiBox(Color.fromRGBO(107, 93, 128, 1), 24),
                      Container(
                        width: 20,
                      ),
                      getEmiBox(Color.fromRGBO(68, 85, 123, 1), 36),
                    ],
                  ),
                ),
              )
            ],
          )),
      collapseWidget: GestureDetector(
        onTap: widget.changePage,
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color.fromRGBO(20, 21, 32, 1),
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
                      Text("Emi",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(113, 132, 145, 0.5),
                              fontFamily: "note_sans",
                              fontWeight: FontWeight.w400)),
                      ValueListenableBuilder(
                          builder: (ctx, value, widget) {
                            return RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "₹" +
                                          (this.widget.amount / value)
                                              .toStringAsFixed(2) +
                                          "/",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(
                                              113, 132, 145, 0.5),
                                          fontFamily: "note_sans",
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: " mo",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(
                                              113, 132, 145, 0.5),
                                          fontFamily: "note_sans",
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            );
                          },
                          valueListenable: emiMonthNotifier)
                    ])),
                Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("duration",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(113, 132, 145, 0.5),
                              fontFamily: "note_sans",
                              fontWeight: FontWeight.w400)),
                      ValueListenableBuilder(
                          builder: (ctx, value, widget) {
                            return Text("$value months",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(113, 132, 145, 0.5),
                                    fontFamily: "note_sans",
                                    fontWeight: FontWeight.w600));
                          },
                          valueListenable: emiMonthNotifier)
                    ])),
                IconButton(
                    color: Color.fromRGBO(143, 157, 158, 1),
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      widget.changePage();
                    })
              ],
            )),
      ),
      controller: widget.controller,
    );
  }

  getEmiBox(Color color, int months) {
    return ValueListenableBuilder(
        builder: (ctx, value, widget) {
          return Container(
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  emiMonthNotifier.value = months;
                },
                child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: value == months
                              ? Colors.black.withOpacity(0.1)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: value != months
                              ? Border.all(color: Colors.white54)
                              : Border.all(color: Colors.transparent),
                        ),
                        child: value != months
                            ? Container()
                            : Icon(
                                Icons.check,
                                color: Color.fromRGBO(239, 185, 190, 1),
                              ),
                      ),
                      Container(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "₹" +
                                (this.widget.amount / months)
                                    .toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(249, 237, 254, 1),
                                fontFamily: "note_sans",
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: " /mo",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(113, 132, 145, 1),
                                fontFamily: "note_sans",
                                fontWeight: FontWeight.w300))
                      ])),
                      Container(
                        height: 8,
                      ),
                      Text("for $months months",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(249, 237, 254, 1),
                              fontFamily: "note_sans",
                              fontWeight: FontWeight.w500)),
                      Container(
                        height: 10,
                      ),
                      Text("see calculation",
                          style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(249, 237, 254, 1),
                              fontFamily: "note_sans",
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        valueListenable: emiMonthNotifier);
  }
}
