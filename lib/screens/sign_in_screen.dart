import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInScreen extends StatefulWidget {
  final FirebaseAuth auth;
  const SignInScreen({Key? key, required this.auth}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _success = '';
  String _userEmail = '';
  String _signInS = 'Sign In';
  String _registerS = 'Register';
  String _signOutS = '';

  @override
  void initState() {
    _authListener();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    widget.auth.authStateChanges().listen((event) {}).cancel();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await widget.auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
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

  Future<void> _signOut() async {
    await widget.auth.signOut();
  }

  Future<void> _authListener() async {
    widget.auth.authStateChanges().listen((User? user) {
      setState(() {
        if (user == null) {
          _registerS = 'Register';
          _signInS = 'Sign In';
          _signOutS = '';
          _emailController.text = '';
          _passwordController.text = '';
          _success = 'false';
        } else {
          Navigator.pop(context);
          // _registerS = 'Sign Out';
          // String name = '';
          // if (user.email != null) {
          //   name = user.email!.split('@').first;
          // }
          // _signInS = '$name';
          // _signOutS = 'Sign Out';
          // _success = 'true';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6b705c),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your email address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password',
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              child: SignInButton(
                Buttons.Email,
                text: _signInS,
                onPressed: () async {
                  await _signInWithEmailAndPassword();
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success == ''
                  ? ''
                  : (_success == 'true'
                      ? 'Successfully registered $_userEmail'
                      : 'Registration failed')),
            )
          ],
        ),
      ),
    );
  }
}
