import 'package:humankind/models/user.dart';

class UsersModel {
  late List<UserModel> users = [];

  UsersModel({List<UserModel>? users}) {
    if (users != null) {
      this.users = List.from(users);
    }
  }

  factory UsersModel.fromJson(dynamic json) {
    UsersModel users = UsersModel();
    if (json['users'] != null) {
      final list = json['users'];
      for (final user in list) {
        users.users.add(UserModel.fromJson(user));
      }
    }
    return users;
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> usersMap = [];
    for (final UserModel user in users) {
      final Map<String, dynamic> resMap = user.toJson();
      usersMap.add(resMap);
    }
    return {
      'users': usersMap,
    };
  }
}
