import 'package:crud/addproduct.dart';
import 'package:crud/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: welcomedrawer(),
      body: welcomebody(),
    );
  }
}

class welcomebody extends StatelessWidget {
  const welcomebody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class welcomedrawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;
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
          Text("Email"),
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
                  await auth.signOut();
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
