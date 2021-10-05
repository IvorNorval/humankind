import 'package:flutter/material.dart';
import 'package:humankind/models/project.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';

class AddProjectScreen extends StatefulWidget {
  final UsersModel users;
  final int index;
  const AddProjectScreen({Key? key, required this.users, required this.index})
      : super(key: key);

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _discController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _discController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6b705c),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your project name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: TextFormField(
                controller: _discController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter project description',
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  ProjectModel project = ProjectModel(
                      name: _nameController.text,
                      description: _discController.text);
                  widget.users.users[widget.index].projects.add(project);
                  updateUser(widget.users);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Add project')),
          ],
        ),
      ),
    );
  }
}
