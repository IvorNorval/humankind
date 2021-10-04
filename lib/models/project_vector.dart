import 'package:humankind/models/project.dart';

class ProjectVector {
  final ProjectModel project;
  final int projectIndex;
  final int usersIndex;

  ProjectVector(
      {required this.project,
      required this.projectIndex,
      required this.usersIndex});
}
