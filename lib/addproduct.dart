import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:io';

class addproducts extends StatefulWidget {
  const addproducts({Key? key}) : super(key: key);

  @override
  State<addproducts> createState() => _addproductsState();
}

class _addproductsState extends State<addproducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addproductsbody(),
    );
  }
}

class addproductsbody extends StatefulWidget {
  @override
  State<addproductsbody> createState() => _addproductsbodyState();
}

class _addproductsbodyState extends State<addproductsbody> {
  String? name;
  String? descp;
  String? avail;
  int? time;
  void getcurrenttime() {
    time = DateTime.now().microsecondsSinceEpoch;
    setState(() {});
  }

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.37,
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
                    "Add your product",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              builder: (context) => welcome(),
                            ),
                          );
                        },
                        child: Text(
                          'Don\'t wanna add the product ?',
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
                        labelText: "Name of product"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      descp = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ), //<-- SEE HERE
                        ),
                        labelText: "Description"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      avail = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ), //<-- SEE HERE
                        ),
                        labelText: "Availability"),
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
                                          Text('Enter Name of product !'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (descp == null) {
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
                                          Text('Enter Desciption of product !'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (avail == null) {
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
                                          Text(
                                              'Enter Availability of product !'),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            final user = await FirebaseFirestore.instance;
                            HashMap<String, String> map =
                                HashMap<String, String>();
                            map["Name"] = name!;
                            map["Description"] = descp!;
                            map["Availability"] = avail!;
                            map["UID"] = auth.currentUser!.uid;
                            map["PID"] = time.toString();
                            await user
                                .collection("Products")
                                .doc(time.toString())
                                .set(map);
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
                      child: Text('Add Product'),
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
