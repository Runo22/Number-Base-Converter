import 'dart:math';
import 'package:convert_hex/convert_hex.dart';
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
  final hexController = TextEditingController();
  final regxbinary = RegExp(r'^[0-1]{1,}$');
  final regxhex = RegExp(r'^[0-9a-f]+$');

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
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: new Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Row(
                      children: <Widget>[
                        Text("Binary",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        FlatButton(
                          child: Icon(Icons.content_copy),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: binaryController.text));
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Binary number copied to clipboard!'),
                              duration: Duration(milliseconds: 700),
                            ));
                          },
                        )
                      ],
                    )),
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                      hintText: "Binary Number",
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                          hexController.text = "";
                        });
                      } else if (!regxbinary.hasMatch(text)) {
                        checkifbinary(text);
                      }
                      updateNumbers(binaryController.text, 0);
                    },
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Row(
                      children: <Widget>[
                        Text("Decimal",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        FlatButton(
                          child: Icon(Icons.content_copy),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: decimalController.text));
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Decimal number copied to clipboard!'),
                              duration: Duration(milliseconds: 700),
                            ));
                          },
                        )
                      ],
                    )),
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                      hintText: "Decimal Number",
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                          hexController.text = "";
                        });
                      }
                      updateNumbers(text, 1);
                    },
                  ),
                  new SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Row(
                      children: <Widget>[
                        Text("Hex",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        FlatButton(
                          child: Icon(Icons.content_copy),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: hexController.text));
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Hex number copied to clipboard!'),
                              duration: Duration(milliseconds: 700),
                            ));
                          },
                        )
                      ],
                    )),
                  ),
                  new TextField(
                    decoration: new InputDecoration(
                      hintText: "Hex Number",
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                    controller: hexController,
                    onChanged: (text) {
                      if (text.isEmpty) {
                        setState(() {
                          decimalController.text = "";
                          binaryController.text = "";
                        });
                      } else if (!regxhex.hasMatch(text)) {
                        checkifhex(text);
                      }
                      updateNumbers(text, 2);
                    },
                  ),
                  new SizedBox(
                    height: 200,
                  ),
                  new Text("Maximum decimal number is 9223372036854775807")
                ],
              ),
            ),
          );
        }));
  }

  void updateNumbers(String sayik, int bintodec) {
    if (bintodec == 2) {
      if (hexController.text.isEmpty) {
        binaryController.text = "";
        decimalController.text = "";
      } else {
        String sayit = Hex.decode(sayik).toString();
        decimalController.text = sayit;
        updateNumbers(sayit, 11);
      }
    } else {
      print("11");
      int sayi = int.parse(sayik);
      if (bintodec == 0) {
        fromBinary(sayi);
      } else if (bintodec == 1 || bintodec == 11) {
        print("geleyo");
        if (bintodec == 1) {
          setState(() {
            hexController.text = Hex.encode(sayi).toString();
          });
        }
        print("here");
        binaryController.text = "";
        fromDecimal(sayi);
      }
    }
  }

  fromBinary(int binary) {
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
      hexController.text = Hex.encode(decimal).toString();
    });
  }

  fromDecimal(int n) {
    if (n > 1) {
      fromDecimal(n ~/ 2);
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

  void checkifhex(String gok) {
    setState(() {
      hexController.text = gok.substring(0, gok.length - 1);
      hexController.selection = TextSelection.fromPosition(
          TextPosition(offset: hexController.text.length));
    });
  }
}
