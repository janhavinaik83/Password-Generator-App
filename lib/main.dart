import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_generator_app/user.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isChecked = false;
  bool iChecked = false;
  bool issChecked = false;
  bool isssChecked = false;
  TextEditingController lengthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    lengthController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF006064),
          title: Text("Password Generator"),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/img45.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(32),
          child: ListView(
            children: [
              Column(
                children: [
                  Image.asset('images/passy.jpg', width: 200, height: 200),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: Text("Uppercase")),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Expanded(child: Text("Lowercase")),
                      Checkbox(
                        value: iChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            iChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Numbers")),
                      Checkbox(
                        value: issChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            issChecked = value!;
                          });
                        },
                      ),
                      Expanded(child: Text("Symbols")),
                      Checkbox(
                        value: isssChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isssChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Length")),
                      const SizedBox(height: 90),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: lengthController,
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
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/drawerback.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Builder(
              builder: (context) => ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "You deserve to get hacked if your password is your name!!",
                        style: TextStyle(
                          color: Color(0xFFB71C1C),
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(Icons.password_rounded),
                    title: Text(
                      "User choice password",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserChoice("User Choice Password"),
                        ),
                      );
                    },
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
    final lengths = int.tryParse(lengthController.text) ?? 0;
    final letterlower = 'abcdefghijklmnopqrstuvwxyz';
    final letterupper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    final special = '@#\$%&*!+=-?/^[]{}<>,.()';

    if (iChecked) chars += letterlower;
    if (isChecked) chars += letterupper;
    if (issChecked) chars += numbers;
    if (isssChecked) chars += special;

    if (chars.isEmpty) return '';

    return List.generate(lengths, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  void reset() {
    lengthController.text = '';
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
