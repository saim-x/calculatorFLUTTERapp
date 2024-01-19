// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String buttonText = "Turn On"; // Initial button text
  String hintText = "Select an option:";
  String inputFieldText = "";

  void evaluationkafunction() {
    if (inputFieldText.endsWith('=')) {
      print("Equal pressed");
      // print("'$inputFieldText' -> ${inputFieldText.interpret()}");
      try {
        // Use a simple parser to evaluate arithmetic expressions

        print(eval(inputFieldText));
        setState(() {
          inputFieldText = eval(inputFieldText).toString();
        });
      } catch (e) {
        print("Error interpreting expression: $e");
        setState(() {
          inputFieldText = "";
        });
        // Handle the error accordingly
      }
    }

    // C logic
    if (inputFieldText.endsWith('C')) {
      setState(() {
        inputFieldText = '';
      });
    }
  }

  double eval(String expression) {
    try {
      expression = expression.replaceAll("=", "");
      // Create a parser and evaluate the expression
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      // Handle invalid input or parsing errors
      print("Error interpreting expression: $e, Expression: '$expression'");
      // Rethrow the exception or return a default value, depending on your use case
      throw FormatException("Invalid expression");
    }
  }

  Widget buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        print(buttonText);
        setState(() {
          hintText = "";
          inputFieldText = inputFieldText + buttonText;
          evaluationkafunction();
        });
      },
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 0, 0, 0), // Button color
        onPrimary: Colors.black, // Text color
        padding: EdgeInsets.all(15), // Button padding
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Calculator',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                //input field
                Column(
                  children: [
                    Text(
                      hintText, // Your hint text
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.7, 50)),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade200), // Button color
                        foregroundColor: MaterialStateProperty.all(
                            Colors.black), // Text color
                      ),
                      child: Text(
                        inputFieldText,
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildButton("7"),
                                buildButton("8"),
                                buildButton("9"),
                                buildButton("/"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildButton("4"),
                                buildButton("5"),
                                buildButton("6"),
                                buildButton("*"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildButton("1"),
                                buildButton("2"),
                                buildButton("3"),
                                buildButton("-"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildButton("0"),
                                buildButton("C"), // Clear button
                                buildButton("="),
                                buildButton("+"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
