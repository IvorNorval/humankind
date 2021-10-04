import 'package:flutter/material.dart';
import 'package:humankind/models/users.dart';

class ProjectScreen extends StatefulWidget {
  final UsersModel users;
  final int index;
  const ProjectScreen({Key? key, required this.users, required this.index})
      : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6b705c),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
