import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: Color(0xff272727)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final binaryController = TextEditingController();
  final decimalController = TextEditingController();
  final regxbinary = RegExp(r'^[0-1]{1,}$');

  @override
  void dispose() {
    binaryController.dispose();
    decimalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffead383),
      appBar: AppBar(
        title: Text('Binary Decimal Converter'),
      ),
      body: Center(
        child: new Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text("Binary",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ),
              new SizedBox(
                height: 7,
              ),
              new TextField(
                decoration: new InputDecoration(
                  hintText: "Binary Number",
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[700]),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[700]),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey,
                ),
                controller: binaryController,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.isEmpty) {
                    setState(() {
                      decimalController.text = "";
                    });
                  }
                  else if (!regxbinary.hasMatch(text)) {
                    checkifbinary(text);
                  }
                  updateNumbers(text, 0);
                },
              ),
              new SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text("Decimal",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ),
              new SizedBox(
                height: 7,
              ),
              new TextField(
                decoration: new InputDecoration(
                  hintText: "Decimal Number",
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[700]),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[700]),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey,
                ),
                controller: decimalController,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.isEmpty) {
                    setState(() {
                      binaryController.text = "";
                    });
                  }
                  updateNumbers(text, 1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateNumbers(sayik, bintodec) {
    int sayi = int.parse(sayik);
    if (bintodec == 0) {
      binaryToDecimal(sayi);
    } else if (bintodec == 1) {
      binaryController.text = "";
      decimalToBinary(sayi);
    }
  }

  binaryToDecimal(int binary) {
    int decimal = 0;
    int i = 0;
    while (binary != 0) {
      int dec = binary % 10;
      decimal = decimal + dec * pow(2, i);
      binary = binary ~/ 10;
      i = i + 1;
    }
    setState(() {
      decimalController.text = decimal.toString();
    });
  }

  decimalToBinary(int n) {
    if (n > 1) {
      decimalToBinary(n ~/ 2);
    }
    setState(() {
      String a = binaryController.text;
      binaryController.text = a + (n % 2).toString();
    });
  }

  void checkifbinary(String gik) {
    setState(() {
    binaryController.text = gik.substring(0, gik.length - 1);
    binaryController.selection = TextSelection.fromPosition(
      TextPosition(offset: binaryController.text.length));
    });
  }
}