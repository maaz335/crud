import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/addproduct.dart';
import 'package:crud/main.dart';
import 'package:crud/productsgetter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: welcomedrawer(),
      body: welcomebody(),
    );
  }
}

class welcomebody extends StatefulWidget {
  const welcomebody({Key? key}) : super(key: key);

  @override
  State<welcomebody> createState() => _welcomebodyState();
}

class _welcomebodyState extends State<welcomebody> {
  List<Object> _products = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return productsgetter(_products[index] as Product);
          }),
    );
  }

  Future getProductsData() async {
    var data = await FirebaseFirestore.instance.collection("Products").get();
    setState(() {
      _products = List.from(data.docs.map((doc) => Product.fromSnapshot(doc)));
    });
  }
}

class welcomedrawer extends StatefulWidget {
  @override
  State<welcomedrawer> createState() => _welcomedrawerState();
}

class _welcomedrawerState extends State<welcomedrawer> {
  final _auth = FirebaseAuth.instance;
  String? getemail() {
    String? email = _auth.currentUser?.email;
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 1.0,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Dear User"),
          SizedBox(
            height: 10,
          ),
          Text(getemail().toString()),
          SizedBox(
            height: 28,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addproducts(),
                  ),
                );
              },
              child: Text("Add Products"),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => mainbody(),
                    ),
                  );
                },
                child: Text("Logout"),
              )),
        ],
      ),
    );
  }
}
