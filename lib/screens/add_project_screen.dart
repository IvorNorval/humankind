import 'package:flutter/material.dart';
import 'package:humankind/models/project.dart';
import 'package:humankind/models/users.dart';
import 'package:humankind/services/db_helper.dart';
import 'package:humankind/widgets/button1.dart';
import 'package:humankind/widgets/text_input.dart';

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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextInput(
                controller: _nameController,
                label: ' Enter your project name',
                isPassword: false,
              ),
              TextInput(
                controller: _discController,
                label: ' Enter project description',
                isPassword: false,
              ),
              Button1(
                label: 'Add project',
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  ProjectModel project = ProjectModel(
                      name: _nameController.text,
                      description: _discController.text);
                  widget.users.users[widget.index].projects.add(project);
                  updateUser(widget.users);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
