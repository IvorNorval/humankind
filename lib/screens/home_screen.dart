import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    _signOut();
    widget.auth.authStateChanges().listen((event) {}).cancel();
    super.dispose();
  }

  Future<void> _register() async {
    await widget.auth.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
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
          _registerS = 'Sign Out';
          String name = '';
          if (user.email != null) {
            name = user.email!.split('@').first;
          }
          _signInS = '$name';
          _signOutS = 'Sign Out';
          _success = 'true';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/crowded-street-yellow.jpg"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Humankind crowdfunding',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xffffe8d6),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 10,
                      child: TextButton(
                        onPressed: () {
                          if (_signInS == 'Sign In') {
                            Navigator.pushNamed(context, 'signIn');
                          }
                        },
                        child: Text(
                          _signInS,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xffffe8d6),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 10,
                      child: TextButton(
                        onPressed: () {
                          if (_registerS == 'Register') {
                            Navigator.pushNamed(context, 'register');
                          } else {
                            _signOut();
                          }
                        },
                        child: Text(
                          _registerS,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xffffe8d6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
