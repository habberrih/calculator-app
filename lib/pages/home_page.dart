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
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && numberTwo.isNotEmpty) {
        // TODO
      }

      operand = value;
    }

    setState(() {
      numberOne += value;
      operand += value;
      numberTwo += value;
    });
  }
}
