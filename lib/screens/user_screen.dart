import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';

import 'add_project_screen.dart';

class UserScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final UsersModel users;
  final int index;
  const UserScreen(
      {Key? key, required this.auth, required this.users, required this.index})
      : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserModel user;
  @override
  void initState() {
    if (widget.index > -1) {
      user = widget.users.users[widget.index];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: const Color(0xffafa060),
        appBar: AppBar(
          backgroundColor: const Color(0xff634310),
          title: Text(
            user.name,
            style: const TextStyle(
              color: Color(0xffdbf4ad),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xffdbf4ad),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProjectScreen(
                        users: widget.users,
                        index: widget.index,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffa5aa52),
                    ),
                    child: const Text(
                      'Add project',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 440,
                child: ListView.builder(
                  itemCount: widget.users.users[widget.index].projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.view_in_ar),
                          title: Text(widget
                              .users.users[widget.index].projects[index].name),
                          subtitle: Text(widget.users.users[widget.index]
                              .projects[index].description),
                          trailing: Text(
                              '\$${widget.users.users[widget.index].projects[index].donations.toStringAsFixed(2)}'),
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
}
