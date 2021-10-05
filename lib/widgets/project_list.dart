import 'package:flutter/material.dart';
import 'package:humankind/models/project_vector.dart';
import 'package:humankind/models/user.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/screens/project_screen.dart';

class ProjectsWidget extends StatefulWidget {
  final List<ProjectVector> projects;
  final UsersModel users;
  final UserModel loggedInUser;
  const ProjectsWidget(
      {Key? key,
      required this.projects,
      required this.users,
      required this.loggedInUser})
      : super(key: key);

  @override
  State<ProjectsWidget> createState() => _ProjectsWidgetState();
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: widget.projects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectScreen(
                      project: widget.projects[index],
                      loggedInUser: widget.loggedInUser,
                      users: widget.users,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.view_in_ar),
                    title: Text(widget.projects[index].project.name),
                    subtitle: Text(widget.projects[index].project.description),
                    trailing: Text(
                        '\$${widget.projects[index].project.donations.toStringAsFixed(2)}'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
