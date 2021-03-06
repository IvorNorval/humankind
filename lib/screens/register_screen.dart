import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';
import 'package:humankind/widgets/button1.dart';
import 'package:humankind/widgets/text_input.dart';

class RegisterScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final UsersModel users;
  const RegisterScreen({Key? key, required this.auth, required this.users})
      : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late StreamSubscription lister;

  @override
  void initState() {
    _authListener();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    lister.cancel();
    super.dispose();
  }

  Future<void> _register() async {
    try {
      await widget.auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.code),
            actions: [
              ElevatedButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  Future<void> _authListener() async {
    lister = widget.auth.authStateChanges().listen(
      (User? user) {
        setState(
          () {
            if (user == null) {
              _emailController.text = '';
              _passwordController.text = '';
            } else {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafa060),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/crowded-street-yellow.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextInput(
              controller: _nameController,
              label: ' Enter your name',
              isPassword: false,
            ),
            TextInput(
              controller: _emailController,
              label: ' Enter your email address',
              isPassword: false,
            ),
            TextInput(
              controller: _passwordController,
              label: ' Enter your password',
              isPassword: true,
            ),
            Button1(
              label: 'Register',
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (_nameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  await _register();
                  UserModel user = UserModel(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim());
                  widget.users.users.add(user);
                  updateUser(widget.users);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
