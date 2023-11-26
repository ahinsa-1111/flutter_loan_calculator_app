import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  String? selected;
  double? totalIntrest;
  double? monthlyIntrest;
  double? monthlyInstallment;

  void loancalculate() {
    final amount = int.parse(_controller1.text) - int.parse(_controller2.text);
    final tinterest =
        amount * (double.parse(_controller3.text) / 100) * int.parse(selected!);
    final minterest = tinterest / (int.parse(selected!) * 12);
    final minstall = (amount + tinterest) / (int.parse(selected!) * 12);
    setState(() {
      totalIntrest = tinterest;
      monthlyIntrest = minterest;
      monthlyInstallment = minstall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.notes,
          color: Colors.black,
        ),
        toolbarHeight: 20,
        backgroundColor: Colors.yellow,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.info,
                size: 20, //left side icon
                color: Colors.black),
          ),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Container(
            height: 80, //top yellow border
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20.0), // car loan title alinment
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Car Loan Calculator",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10, //first sized box alignment
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputForm(
                    title: "Car Price",
                    hintText: "e.g 900000",
                    controller: _controller1),
                inputForm(
                    title: "Down Payment",
                    hintText: "e.g 9000",
                    controller: _controller2),
                inputForm(
                    title: "Intrest Rate",
                    hintText: "e.g 3.5",
                    controller: _controller3),
                Text(
                  "Loan Period",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    loanPeriod("1"),
                    loanPeriod("2"),
                    loanPeriod("3"),
                    loanPeriod("4"),
                    loanPeriod("5"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    loanPeriod("6"),
                    loanPeriod("7"),
                    loanPeriod("8"),
                    loanPeriod("9"),
                  ],
                ),
                SizedBox(
                  height: 30, //bottom sized box alignment
                ),
                GestureDetector(
                  onTap: () {
                    loancalculate();
                    Future.delayed(Duration.zero);
                    showModalBottomSheet(
                        isDismissible: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 400,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Result",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Result(
                                      title: "Total Interest",
                                      amount: totalIntrest),
                                  Result(
                                      title: "Monthly Interest",
                                      amount: monthlyIntrest),
                                  Result(
                                      title: "Monthly Installment",
                                      amount: monthlyInstallment)
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget Result({String? title, double? amount}) {
    return ListTile(
      title: Text(
        title!,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Text(
          "RS." + amount!.toStringAsFixed(2),
          style: TextStyle(fontSize: 19),
        ),
      ),
    );
  }

  Widget loanPeriod(String? title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 20, 0),
        child: Container(
          height: 40, //yellow box height and width
          width: 40,
          decoration: BoxDecoration(
            border: title == selected
                ? Border.all(color: Colors.red, width: 2)
                : null,
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(child: Text(title!)),
        ),
      ),
    );
  }

  Widget inputForm(
      {String? title, TextEditingController? controller, String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5, //input container alignment
        ),
        Container(
          height: 40, //input container height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hintText),
          ),
        ),
        SizedBox(
          height: 10, //height between input container
        )
      ],
    );
  }
}
