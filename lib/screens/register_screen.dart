import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

class RegisterScreen extends StatefulWidget {
  final FirebaseAuth auth;
  const RegisterScreen({Key? key, required this.auth}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _status = '';
  String _userEmail = '';
  String _registerS = 'Register';

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

  Future<void> _register() async {
    try {
      final User? user = (await widget.auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ))
          .user;
      if (user != null) {
        setState(() {
          _status = 'in';
        });
      } else {
        _status = 'error';
      }
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
          _emailController.text = '';
          _passwordController.text = '';
          _status = '';
        } else {
          Navigator.pop(context);
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
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: SignInButtonBuilder(
                icon: Icons.person_add,
                backgroundColor: Colors.blueGrey,
                onPressed: () async {
                  await _register();
                },
                text: _registerS,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_status == ''
                  ? ''
                  : (_status == 'in'
                      ? 'Successfully registered $_userEmail'
                      : 'Registration failed')),
            ),
          ],
        ),
      ),
    );
  }
}
