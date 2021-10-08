import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/widgets/button1.dart';

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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/crowded-street-yellow.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
              Button1(
                label: 'Add project',
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
