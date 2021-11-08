import 'package:expandable_view/expandableview.dart';
import 'package:flutter/material.dart';

class BankAccountSelection extends StatelessWidget {
  final ExpandableViewController controller;
  final Function changePage;
  const BankAccountSelection({Key key, this.controller, this.changePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableView(
      expandedWidget: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color.fromRGBO(20, 31, 48, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Where do we send the money?",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(113, 132, 145, 1),
                      fontFamily: "note_sans",
                      fontWeight: FontWeight.bold)),
              Container(
                height: 5,
              ),
              Text(
                  "amount will be credited to this account,EMI will also be debited from this account",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(113, 132, 145, 0.5),
                      fontFamily: "note_sans",
                      fontWeight: FontWeight.w400)),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getBankAccountWidget(
                        "images/hdfc.jpg", "501020003023", "HDFC Bank")
                  ],
                ),
              ),
            ],
          )),
      collapseWidget: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color.fromRGBO(20, 31, 48, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Bank",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(113, 132, 145, 0.5),
                            fontFamily: "note_sans",
                            fontWeight: FontWeight.w400)),
                    Container(
                      height: 3,
                    ),
                    Text("HDFC 501020003023",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(113, 132, 145, 0.5),
                            fontFamily: "note_sans",
                            fontWeight: FontWeight.w600))
                  ])),
              IconButton(
                  color: Color.fromRGBO(143, 157, 158, 1),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: changePage)
            ],
          )),
      controller: controller,
    );
  }

  getBankAccountWidget(String image, String bankAcoountNo, String bankName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    image,
                    width: 30,
                    height: 30,
                  )),
              Container(
                width: 10,
              ),
              Column(
                children: [
                  Text(bankName,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(249, 237, 254, 1),
                          fontFamily: "note_sans",
                          fontWeight: FontWeight.w600)),
                  Container(
                    height: 5,
                  ),
                  Text(bankAcoountNo,
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(249, 237, 254, 0.6),
                          fontFamily: "note_sans",
                          fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: Color.fromRGBO(239, 185, 190, 1),
          ),
        ),
      ],
    );
  }
}
