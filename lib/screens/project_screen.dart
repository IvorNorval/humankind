import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:humankind/models/donor.dart';
import 'package:humankind/models/project.dart';
import 'package:humankind/models/project_vector.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';

class ProjectScreen extends StatefulWidget {
  final ProjectVector project;
  final UsersModel users;
  final UserModel loggedInUser;
  const ProjectScreen(
      {Key? key,
      required this.project,
      required this.users,
      required this.loggedInUser})
      : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late UsersModel users = widget.users;
  late ProjectModel project = widget.users.users[widget.project.usersIndex]
      .projects[widget.project.projectIndex];
  late double donations = widget.users.users[widget.project.usersIndex]
      .projects[widget.project.projectIndex].donations;
  late List<Donor> donors = widget.users.users[widget.project.usersIndex]
      .projects[widget.project.projectIndex].donors;

  void _usersCallback(UsersModel event) {
    setState(() {
      users = event;
      project = users.users[widget.project.usersIndex]
          .projects[widget.project.projectIndex];
      donations = users.users[widget.project.usersIndex]
          .projects[widget.project.projectIndex].donations;
      donors = users.users[widget.project.usersIndex]
          .projects[widget.project.projectIndex].donors;
    });
  }

  @override
  void initState() {
    initStream(_usersCallback);
    super.initState();
  }

  @override
  void dispose() {
    cancelStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafa060),
      appBar: AppBar(
        title: Text(
          widget.project.project.name,
          style: const TextStyle(
            color: Color(0xffdbf4ad),
          ),
        ),
        backgroundColor: const Color(0xff634310),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Created by ${widget.users.users[widget.project.usersIndex].name}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xffdbf4ad),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  widget.project.project.description,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xffdbf4ad),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '\$${donations.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color(0xffdb3a34),
                  ),
                ),
              ),
              IconButton(
                iconSize: 100,
                onPressed: () {
                  var rng = Random();
                  double rnValue = (rng.nextDouble() * 100);
                  users
                      .users[widget.project.usersIndex]
                      .projects[widget.project.projectIndex]
                      .donations += rnValue;
                  users.users[widget.project.usersIndex]
                      .projects[widget.project.projectIndex].donors
                      .insert(
                    0,
                    Donor(
                      donor: '${widget.loggedInUser.name} donated \$'
                          '${rnValue.toStringAsFixed(2)}',
                    ),
                  );
                  updateUser(users);

                  if (users.users[widget.project.usersIndex]
                          .projects[widget.project.projectIndex].donations >
                      500) {
                    showAlertDialog(context);
                  }
                },
                icon: Image.asset(
                  'assets/icons/donate_icon.png',
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 440,
                child: ListView.builder(
                  itemCount: donors.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: const Text(
                            'Thanks!',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xffa5aa52),
                            ),
                          ),
                          title: Text(donors[index].donor),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xffdb3a34),
      title: Image.asset(
        'assets/images/mad_it.gif',
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
