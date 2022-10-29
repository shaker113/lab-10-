import 'package:flutter/material.dart';
import 'package:lab10/widgets/widgets.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("login"),
          AddVertecailSpacing(50),
          customTextField(
              hint: "Email",
              visbleText: false,
              inputType: TextInputType.emailAddress),
          AddVertecailSpacing(50),
          customTextField(
              hint: "password",
              visbleText: true,
              inputType: TextInputType.text),
          AddVertecailSpacing(50),
          customElevatedBotton(theFunction: () async {}, theText: "login")
        ],
      ),
    );
  }
}
