import 'package:flutter/material.dart';
import 'package:humankind/models/project_vector.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';

class ProjectsWidget extends StatelessWidget {
  final List<ProjectVector> projects;
  final UsersModel users;
  const ProjectsWidget({Key? key, required this.projects, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                users.users[projects[index].usersIndex]
                    .projects[projects[index].projectIndex].donations += 20;
                updateUser(users);
              },
              child: Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/icons/donate_icon.png',
                    color: const Color(0xff6b705c),
                  ),
                  title: Text(projects[index].project.name),
                  subtitle: Text(projects[index].project.description),
                  trailing: Text(
                      '\$${projects[index].project.donations.toStringAsFixed(2)}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
