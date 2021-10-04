import 'package:humankind/models/project.dart';

class UserModel {
  final String name;
  final String email;
  late List<ProjectModel> projects = [];

  UserModel(
      {required this.name, required this.email, List<ProjectModel>? projects}) {
    if (projects != null) {
      this.projects = List.from(projects);
    } else {
      projects = [];
    }
  }

  UserModel cloneUserModel() {
    final UserModel cloneTo = UserModel(name: name, email: email);
    cloneTo.projects.clear();
    for (final ProjectModel rm in projects) {
      cloneTo.projects.add(rm.cloneProjectModel());
    }
    return cloneTo;
  }

  factory UserModel.fromJson(dynamic json) {
    final UserModel user = UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
    );
    if (json['projects'] != null) {
      final list = json['projects'];
      final List<ProjectModel> projects = [];
      for (final project in list) {
        projects.add(ProjectModel.fromJson(project));
      }
      user.projects = List.from(projects);
    }
    return user;
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> projectsMap = [];
    for (final ProjectModel project in projects) {
      final Map<String, dynamic> resMap = project.toJson();
      projectsMap.add(resMap);
    }
    return {
      'name': name,
      'email': email,
      'projects': projectsMap,
    };
  }
}
