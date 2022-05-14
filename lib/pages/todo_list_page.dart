import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Email@exemplo.com",
            hintStyle: TextStyle(fontSize: 14),

            // border: InputBorder.none
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      )),
    );
  }
}
