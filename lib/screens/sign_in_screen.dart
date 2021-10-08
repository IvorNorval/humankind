import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humankind/widgets/button1.dart';
import 'package:humankind/widgets/text_input.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignInScreen extends StatefulWidget {
  final FirebaseAuth auth;
  const SignInScreen({Key? key, required this.auth}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
    _emailController.dispose();
    _passwordController.dispose();
    lister.cancel();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
              widget.auth.authStateChanges().listen((event) {}).cancel();
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
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
                label: 'Sign In',
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await _signInWithEmailAndPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
