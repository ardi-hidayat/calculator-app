import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var input = '';
  var result = '';

  final List<String> button = [
    'AC',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'DEL',
    '=',
  ];

  bool _operator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void _count() {
    String finalInput = input;
    finalInput = input.replaceAll('x', '*');

    Parser parser = Parser();
    Expression expression = parser.parse(finalInput);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    result = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Program Kalkulator",
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      input,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: button.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return CustomeButton(
                    onTap: () {
                      setState(() {
                        input = '';
                        result = '0';
                      });
                    },
                    buttonText: button[index],
                    color: Colors.grey.shade300,
                    textColor: Colors.black,
                  );
                } else if (index == 1) {
                  return CustomeButton(
                    buttonText: button[index],
                    color: Colors.grey.shade300,
                    textColor: Colors.black,
                  );
                } else if (index == 2) {
                  return CustomeButton(
                    onTap: () {
                      setState(() {
                        input += button[index];
                      });
                    },
                    buttonText: button[index],
                    color: Colors.grey.shade300,
                    textColor: Colors.black,
                  );
                } else if (index == 18) {
                  return CustomeButton(
                    onTap: () {
                      setState(() {
                        if (input.isNotEmpty) {
                          input = input.substring(0, input.length - 1);
                        }
                      });
                    },
                    buttonText: button[index],
                    color: Colors.red.shade400,
                    textColor: Colors.white,
                  );
                } else if (index == 19) {
                  return CustomeButton(
                    onTap: () {
                      setState(() {
                        _count();
                      });
                    },
                    buttonText: button[index],
                    color: Colors.orange.shade700,
                    textColor: Colors.white,
                  );
                } else {
                  return CustomeButton(
                    onTap: () {
                      setState(() {
                        input += button[index];
                      });
                    },
                    buttonText: button[index],
                    color: _operator(button[index])
                        ? Colors.orange.shade700
                        : Colors.grey.shade700,
                    textColor:
                        _operator(button[index]) ? Colors.white : Colors.white,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
