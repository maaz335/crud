import 'package:crud/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signupbody(),
    );
  }
}

class signupbody extends StatefulWidget {
  @override
  State<signupbody> createState() => _signupbodyState();
}

class _signupbodyState extends State<signupbody> {
  final auth = FirebaseAuth.instance;

  String? name;

  String? email;

  String? pass;

  String? co_pass;

  String? age;

  bool passw = true;

  bool co_passw = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.57,
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
                    "Sign Up Form",
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
                              builder: (context) => mainbody(),
                            ),
                          );
                        },
                        child: Text(
                          'Already registered ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ), //<-- SEE HERE
                        ),
                        labelText: "Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      age = value.toString();
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ), //<-- SEE HERE
                        ),
                        labelText: "Age"),
                  ),
                  SizedBox(
                    height: 10,
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
                    height: 10,
                  ),
                  TextField(
                    obscureText: co_passw,
                    onChanged: (value) {
                      co_pass = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            if (co_passw == true) {
                              co_passw = false;
                            } else {
                              co_passw = true;
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
                        labelText: "Confirm Password"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (name == null) {
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
                                          Text('Enter your name !'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (age == null) {
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
                                          Text('Enter your Age !'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (email == null) {
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
                                          Text('Enter your Email !'),
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
                                          Text('Enter your Password !'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (co_pass == null) {
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
                                          Text('Enter your Confirm Password !'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (pass != co_pass) {
                            showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Warning'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text('Password Didn\'t Match\n'
                                              'Enter Again..'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            await auth.createUserWithEmailAndPassword(
                                email: email!, password: co_pass!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => mainbody(),
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
                      child: Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
