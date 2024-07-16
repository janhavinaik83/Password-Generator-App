import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserChoice extends StatefulWidget {
  final String title;
  UserChoice(this.title);

  @override
  _UserChoiceState createState() => _UserChoiceState();
}

class _UserChoiceState extends State<UserChoice> {
  TextEditingController uppercase = TextEditingController();
  TextEditingController lowercase = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController symbol = TextEditingController();
  TextEditingController length = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    uppercase.dispose();
    lowercase.dispose();
    number.dispose();
    symbol.dispose();
    length.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF006064),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/img45.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(32),
            child: Center(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Image.asset('images/passy.jpg', width: 200, height: 150),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: uppercase,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Uppercase",
                          hintText: "Enter Uppercase letters",
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: lowercase,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Lowercase",
                          hintText: "Enter Lowercase letters",
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Number",
                                hintText: "Enter Numbers",
                              ),
                            ),
                          ),
                          Container(width: 5.0),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: symbol,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Symbol",
                                hintText: "Enter Special Symbols",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("Length")),
                          const SizedBox(width: 5),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: length,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Random Password Generator",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFFB71C1C),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: passwordController,
                        readOnly: true,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.copy),
                            onPressed: () {
                              final data = ClipboardData(text: passwordController.text);
                              Clipboard.setData(data);

                              Fluttertoast.showToast(
                                msg: "Copied",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(child: buildButton()),
                          SizedBox(width: 9.0),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFB71C1C),
                              ),
                              child: Text("Reset"),
                              onPressed: () {
                                setState(() {
                                  reset();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String generatePassword() {
    String chars = '';
    final int lengths = int.tryParse(length.text) ?? 0;
    final String letterLower = lowercase.text;
    final String letterUpper = uppercase.text;
    final String numbers = number.text;
    final String special = symbol.text;

    chars += letterLower;
    chars += letterUpper;
    chars += numbers;
    chars += special;

    if (chars.isEmpty) return '';

    return List.generate(lengths, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  void reset() {
    uppercase.text = '';
    lowercase.text = '';
    number.text = '';
    symbol.text = '';
    length.text = '';
    passwordController.text = '';
  }

  Widget buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF006064)),
      child: Text("Generate Password"),
      onPressed: () {
        final password = generatePassword();
        passwordController.text = password;
      },
    );
  }
}


