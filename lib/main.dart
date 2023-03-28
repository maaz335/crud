import 'package:crud/signup.dart';
import 'package:crud/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'forgotpassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: mainbody(),
      theme: ThemeData(fontFamily: "Roboto"),
    ),
  );
}

class mainbody extends StatefulWidget {
  @override
  State<mainbody> createState() => _mainbodyState();
}

class _mainbodyState extends State<mainbody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainbodycont(),
    );
  }
}

class mainbodycont extends StatefulWidget {
  @override
  State<mainbodycont> createState() => _mainbodycontState();
}

class _mainbodycontState extends State<mainbodycont> {
  final auth = FirebaseAuth.instance;

  String? email;

  String? pass;

  bool passw=true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Color(0xFFffffff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      1.0, // Move to right 5  horizontally
                      1.0, // Move to bottom 5 Vertically
                    ),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login Form",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 27,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signup(),
                            ),
                          );
                        },
                        child: Text(
                          'Don\'t have an account ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ), //<-- SEE HERE
                        ),
                        labelText: "Email"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: passw,
                    onChanged: (value) {
                      pass = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            if (passw == true) {
                              passw = false;
                            } else {
                              passw = true;
                            }
                            setState(() {});
                          },
                          child: Icon(CupertinoIcons.eye_fill),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ), //<-- SEE HERE
                        ),
                        labelText: "Password"),
                  ),
                  SizedBox(
                    height: 27,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => forgotpassword(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (email == null) {
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Note'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Enter your email !'),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else if (pass == null) {
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Note'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Enter your password !'),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              await auth.signInWithEmailAndPassword(
                                  email: email!, password: pass!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => welcome(),
                                ),
                              );
                            }
                          } catch (e) {
                            showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Warning'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(e.toString()),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        child: Text('Login'),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
