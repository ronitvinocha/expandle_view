import 'dart:io';

import 'package:expandable_view/amountselection.dart';
import 'package:expandable_view/bankselection.dart';
import 'package:expandable_view/emiselection.dart';
import 'package:expandable_view/expandableview.dart';
import 'package:expandable_view/successdialog.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cred Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(14, 16, 20, 1),
        primaryColor: Color.fromRGBO(17, 19, 26, 1),
        accentColor: Colors.transparent,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AfterLayoutMixin<MyHomePage>, TickerProviderStateMixin {
  ExpandableViewController amountSelectionController =
      ExpandableViewController(ExpandableState.NOTVISIBLE);
  ExpandableViewController emiSelectionController =
      ExpandableViewController(ExpandableState.NOTVISIBLE);
  ExpandableViewController bankSelectionController =
      ExpandableViewController(ExpandableState.NOTVISIBLE);
  ValueNotifier<int> amountNotifier = ValueNotifier(100000);
  ValueNotifier<int> currentPage = ValueNotifier(0);
  ValueNotifier<String> buttonText = ValueNotifier("Proceed to EMI selection");
  AnimationController _controller;
  Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(_controller);
    currentPage.addListener(_currentPageListener);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromRGBO(14, 16, 20, 1),
    ));
  }

  void _currentPageListener() {
    if (currentPage.value == 0) {
      expandFunction(amountSelectionController);
      changeButton("Proceed to EMI selection");
    } else if (currentPage.value == 1) {
      expandFunction(emiSelectionController);
      changeButton("Select your bank account");
    } else if (currentPage.value == 2) {
      expandFunction(bankSelectionController);
      changeButton("Tap for 1-click KYC");
    }
  }

  @override
  void dispose() {
    currentPage.removeListener(_currentPageListener);
    currentPage.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
              children: [
                Container(
                  height: 30,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => exit(0),
                      child: Container(
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(22, 24, 28, 1)),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Color.fromRGBO(142, 146, 152, 1),
                          )),
                    )
                  ],
                ),
                Container(
                  height: 15,
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                    ),
                    AmountSelection(
                      controller: amountSelectionController,
                      changeCurrentPage: () {
                        currentPage.value = 0;
                      },
                      sendAmountToParent: (amount) {
                        amountNotifier.value = amount;
                      },
                    ),
                    Positioned(
                        top: 100,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ValueListenableBuilder(
                          builder: (ctx, value, widget) {
                            return EmiSelection(
                              amount: value,
                              changePage: () {
                                currentPage.value = 1;
                              },
                              controller: emiSelectionController,
                            );
                          },
                          valueListenable: amountNotifier,
                        )),
                    Positioned(
                        top: 200,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ValueListenableBuilder(
                          builder: (ctx, value, widget) {
                            return BankAccountSelection(
                              changePage: () {
                                currentPage.value = 2;
                              },
                              controller: bankSelectionController,
                            );
                          },
                          valueListenable: amountNotifier,
                        )),
                    Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        child: SlideTransition(
                          position: _animation,
                          child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(20)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(44, 48, 143, 1)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))))),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: ValueListenableBuilder(
                                    valueListenable: buttonText,
                                    builder: (ctx, value, widget) {
                                      return Text(
                                        value,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                195, 167, 215, 1),
                                            fontFamily: "note_sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      );
                                    })),
                            onPressed: () {
                              if (currentPage.value < 2) {
                                currentPage.value = currentPage.value + 1;
                              } else {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    builder: (ctx) {
                                      return SuccessDialog();
                                    });
                              }
                            },
                          ),
                        ))
                  ],
                )),
              ],
            )),
        onWillPop: () {
          if (currentPage.value > 0) {
            currentPage.value = currentPage.value - 1;
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        });
  }

  changeButton(String text) {
    _controller.forward();
    Future.delayed(Duration(milliseconds: 500), () {
      buttonText.value = text;
      _controller.reverse();
    });
  }

  expandFunction(ExpandableViewController controller) {
    if (controller == amountSelectionController) {
      amountSelectionController.setExpandableState(ExpandableState.EXPANDED);
      emiSelectionController.setExpandableState(ExpandableState.NOTVISIBLE);
      bankSelectionController.setExpandableState(ExpandableState.NOTVISIBLE);
    } else if (controller == emiSelectionController) {
      amountSelectionController.setExpandableState(ExpandableState.COLLAPSED);
      emiSelectionController.setExpandableState(ExpandableState.EXPANDED);
      bankSelectionController.setExpandableState(ExpandableState.NOTVISIBLE);
    } else if (controller == bankSelectionController) {
      amountSelectionController.setExpandableState(ExpandableState.COLLAPSED);
      emiSelectionController.setExpandableState(ExpandableState.COLLAPSED);
      bankSelectionController.setExpandableState(ExpandableState.EXPANDED);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    amountSelectionController.setExpandableState(ExpandableState.EXPANDED);
  }
}
