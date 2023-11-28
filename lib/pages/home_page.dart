import 'package:calculator_app/models/buttons.dart';
import 'package:flutter/material.dart';

import '../widgets/build_buttons.dart';

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
        title: const Text('Calculator App', 
        style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //output section,
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child:  Text(
                  "$numberOne$operand$numberTwo".isEmpty ? "0" : "$numberOne$operand$numberTwo",
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
                width: value == Btn.n0? screenSize.width / 2 : (screenSize.width / 4),
                // maybe change it to 'width'
                height: screenSize.width / 5, 
                child: buildButtons(value)
                ),
            ).toList(),
          )
          ],
        ),
      ),
    );
  }
}