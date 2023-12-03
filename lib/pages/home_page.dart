import 'package:calculator_app/models/buttons.dart';
import 'package:flutter/material.dart';

import '../themes/bottuns_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String numberOne = "";
  String operand = ""; // . * / + -
  String numberTwo = ""; // . 0-9
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          //output section,
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  "$numberOne$operand$numberTwo".isEmpty
                      ? "0"
                      : "$numberOne$operand$numberTwo",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          // buttons section
          Wrap(
            children: Btn.buttonValues
                .map(
                  (value) => SizedBox(
                    width: value == Btn.n0
                        ? screenSize.width / 2
                        : (screenSize.width / 4),
                    // maybe change it to 'width'
                    height: screenSize.width / 5,
                    child: buildButtons(value),
                  ),
                )
                .toList(),
          )
        ]),
      ),
    );
  }

  Widget buildButtons(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getButtonColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(100)),
        child: InkWell(
          onTap: () => onButtonTap(value),
          child: Center(
            child: Text(
              value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
        ),
      ),
    );
  }

  void onButtonTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }
    appendValue(value);
  }

  void calculate() {
    if (numberOne.isEmpty) return;
    if (operand.isEmpty) return;
    if (numberTwo.isEmpty) return;

    double numOne = double.parse(numberOne);
    double numTwo = double.parse(numberTwo);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = numOne + numTwo;
        break;
      case Btn.subtract:
        result = numOne - numTwo;
        break;

      case Btn.multiply:
        result = numOne * numTwo;
        break;

      case Btn.divide:
        if (numberTwo == '0') return;
        result = numOne / numTwo;
        break;

      default:
    }

    setState(() {
      numberOne = "$result";
      if (numberOne.endsWith(".0")) {
        numberOne = numberOne.substring(0, numberOne.length - 2);
      }

      operand = "";
      numberTwo = "";
    });
  }

  // converts output to %
  void convertToPercentage() {
    // ex: 432+434
    if (numberOne.isNotEmpty && operand.isNotEmpty && numberTwo.isNotEmpty) {
      // calculate before converting
      calculate();
    }

    if (operand.isNotEmpty) {
      // can't be converted
      return;
    }

    final number = double.parse(numberOne);
    setState(() {
      numberOne = "${(number / 100)}";
      operand = "";
      numberTwo = "";
    });
  }

  void clearAll() {
    setState(() {
      numberOne = "";
      operand = "";
      numberTwo = "";
    });
  }

  void delete() {
    if (numberTwo.isNotEmpty) {
      numberTwo = numberTwo.substring(0, numberTwo.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (numberOne.isNotEmpty) {
      numberOne = numberOne.substring(0, numberOne.length - 1);
    }

    setState(() {});
  }

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && numberTwo.isNotEmpty) {
        calculate();
      }

      operand = value;
    } else if (numberOne.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && numberOne.contains(Btn.dot)) return;
      if (value == Btn.dot && (numberOne.isEmpty || numberOne == Btn.n0)) {
        value = "0.";
      }
      numberOne += value;
    } else if (numberTwo.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && numberTwo.contains(Btn.dot)) return;
      if (value == Btn.dot && (numberTwo.isEmpty || numberTwo == Btn.n0)) {
        value = "0.";
      }
      numberTwo += value;
    }

    setState(() {});
  }
}
