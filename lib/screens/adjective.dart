import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab10/screens/home.dart';
import 'package:lab10/screens/sgin_in.dart';
import 'package:lab10/widgets/bottons.dart';
import 'package:lab10/widgets/spacing.dart';

class AdjectivePage extends StatefulWidget {
  AdjectivePage({super.key});
  static String group = '';

  @override
  State<AdjectivePage> createState() => _AdjectivePageState();
}

class _AdjectivePageState extends State<AdjectivePage> {
  @override
  void initState() {
    checkColor();
    background(userColor);
    super.initState();
  }

  CollectionReference user = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: user.snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData || isList == true || isList == false) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Adjective'),
              centerTitle: true,
            ),
            body: isList == false
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: background(userColor),
                    ),
                    child: const Body(),
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: background(userColor),
                      ),
                    ),
                    child: const Body(),
                  ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text('Please Select Your Adjective'),
          ),
          const SizedBox(height: 20),
          RadioListTile(
            value: 'User',
            groupValue: AdjectivePage.group,
            title: const Text('User'),
            onChanged: (value) {
              setState(() {
                AdjectivePage.group = value.toString();
              });
              DocumentReference<Map<String, dynamic>> role = FirebaseFirestore
                  .instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid);

              role.update({
                'role': value.toString(),
              });
              print(userColor);
              print(isList);
            },
          ),
          RadioListTile(
            value: 'Admin',
            groupValue: AdjectivePage.group,
            title: const Text('Admin'),
            onChanged: (value) {
              setState(() {
                AdjectivePage.group = value.toString();
              });
              var role = FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid);

              role.update({
                'role': value.toString(),
              });
              print(userColor);
              print(isList);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ));
            },
            child: const Text('Enter'),
          ),
          AddVertecailSpacing(50),
          customElevatedBotton(
              theFunction: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
                // userColor = null;
                // isList = null;
                // print(userColor);
                // print(isList);
              },
              theText: "log out")
        ],
      ),
    );
  }
}
