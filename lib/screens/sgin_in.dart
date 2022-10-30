// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_local_variable, use_build_context_synchronously, duplicate_ignore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab10/screens/adjective.dart';
import 'package:lab10/widgets/widgets.dart';
import '../theme/app_color.dart';
import 'sgin_up.dart';

String? userColor;
bool? isList;

void checkColor() async {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot userInfo =
      await FirebaseFirestore.instance.collection('user').doc(user?.uid).get();
  String userRole = userInfo['color'];
  userColor = userRole;
}

background(String? color) {
  if (color == 'White') {
    isList = false;
    return AppColors.white;
  }
  if (color == 'Red') {
    isList = false;
    return AppColors.red;
  }
  if (color == 'Blue') {
    isList = false;
    return AppColors.blue;
  }
  if (color == 'Yellow') {
    isList = false;
    return AppColors.yellow;
  }
  if (color == 'green') {
    isList = false;
    return AppColors.green;
  }
  if (color == 'Red And Blue') {
    isList = true;
    return AppColors.redAndBlue;
  }
  if (color == 'Rainbow') {
    isList = true;
    return AppColors.reinbow;
  }
}

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController Email = TextEditingController();
  TextEditingController PassWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text("login"),
            AddVertecailSpacing(50),
            customTextField(
                theController: Email,
                hint: "Email",
                visbleText: false,
                inputType: TextInputType.emailAddress),
            AddVertecailSpacing(50),
            customTextField(
                theController: PassWord,
                hint: "password",
                visbleText: true,
                inputType: TextInputType.text),
            AddVertecailSpacing(50),
            customElevatedBotton(
                theFunction: () async {
                  try {
                    var authenticationObject = FirebaseAuth.instance;
                    UserCredential myUser =
                        await authenticationObject.signInWithEmailAndPassword(
                            email: Email.text, password: PassWord.text);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("signed in successfully"),
                      ),
                    );
                    setState(() {
                      checkColor();
                      background(userColor);
                    });

                    print(userColor);
                    print(List);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdjectivePage(),
                        ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("The email address or password is wrong"),
                      ),
                    );
                  }
                },
                theText: "login"),
            AddVertecailSpacing(50),
            Row(
              children: [
                const Text("dont have account ?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const sginup(),
                          ));
                    },
                    child: const Text("sgin up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
