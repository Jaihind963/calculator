import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String output = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  SizedBox(height: 20),
                  Text(
                    output,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.history),
                      ),
                    ],
                  ),Divider()
                ],
              ),
            ),
          ),
          Row(
            children: [
              buttonText(text: "AC", buttonBGColor: Colors.orange),
              buttonText(text: "C", textColor: Colors.orange),
              buttonText(text: "%", textColor: Colors.orange),
              buttonText(text: "/", textColor: Colors.orange)
            ],
          ),
          Row(
            children: [
              buttonText(text: "7"),
              buttonText(text: "8"),
              buttonText(text: "9"),
              buttonText(text: "x", textColor: Colors.orange)
            ],
          ),
          Row(
            children: [
              buttonText(text: "4"),
              buttonText(text: "5"),
              buttonText(text: "6"),
              buttonText(text: "-", textColor: Colors.orange)
            ],
          ),
          Row(
            children: [
              buttonText(text: "1"),
              buttonText(text: "2"),
              buttonText(text: "3"),
              buttonText(text: "+", textColor: Colors.orange)
            ],
          ),
          Row(
            children: [
              buttonText(text: "C", textColor: Colors.orange),
              buttonText(text: "0"),
              buttonText(text: ".", textColor: Colors.orange),
              buttonText(text: "=", textColor: Colors.orange)
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonText(
      {required String text,
      Color textColor = Colors.white,
      Color buttonBGColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: buttonBGColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () => buttonFunction(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void buttonFunction(String valueText) {
    if (valueText == "AC") {
      input = "";
      output = "0";
    } else if (valueText == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (valueText == "=") {
      evaluateExpression();
    } else {
      if (hasTwoOperators()) {
        evaluateExpression();
        
      }
      input += valueText;
      updateIntermediateResult();
    }
    setState(() {});
  }

  void evaluateExpression() {
    try {
      var userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = exp.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      input = finalValue.toString();
    } catch (e) {}
  }

  void updateIntermediateResult() {
    try {
      var userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = exp.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
    } catch (e) {}
  }

  bool hasTwoOperators() {
    int operatorCount = 0;
    for (int i = 0; i < input.length; i++) {
      if (isOperator(input[i])) {
        operatorCount++;
      }
    }
    return operatorCount >= 2;
  }

  bool isOperator(String value) {
    return value == "%" ||
        value == "/" ||
        value == "-" ||
        value == "x" ||
        value == "+" ||
        value == ".";
  }
}
