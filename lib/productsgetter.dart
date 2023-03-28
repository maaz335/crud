import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class productsgetter extends StatefulWidget {
  final Product _product;

  productsgetter(this._product);

  @override
  State<productsgetter> createState() => _productsgetterState();
}

class _productsgetterState extends State<productsgetter> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: ListTile(
        title: Text("Name: ${widget._product.Name}"),
        subtitle: Text(
            "Description: ${widget._product.Description}\nAvailability: ${widget._product.Availability}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                if (_auth.currentUser!.uid == widget._product.UID) {
                  ref.doc(widget._product.PID).delete();
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Warning'),
                            content: Text(
                              "You are authorized to delete this Product!",
                            ),
                          ));
                }
                setState(() {});
              },
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.monetization_on,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  String? Availability;
  String? Description;
  String? Name;
  String? UID;
  String? PID;
  Product();
  Map<String, dynamic> toJson() => {
        "Availability": Availability,
        "Description": Description,
        "Name": Name,
        "UID": UID,
        "PID": PID,
      };
  Product.fromSnapshot(snapshot)
      : Availability = snapshot.data()["Availability"],
        Description = snapshot.data()["Description"],
        Name = snapshot.data()["Name"],
        UID = snapshot.data()["UID"],
        PID = snapshot.data()["PID"];
}
