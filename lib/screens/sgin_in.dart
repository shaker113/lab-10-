// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab10/widgets/widgets.dart';

import 'sgin_up.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController Email = TextEditingController();
    TextEditingController PassWord = TextEditingController();

    return Scaffold(
      body: ListView(
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ,));
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
    );
  }
}
