import 'donors.dart';

class ProjectModel {
  final String name;
  final String description;
  late double donations;
  List<Donors> donors = [];

  ProjectModel({
    required this.name,
    required this.description,
    double? donations,
    List<Donors>? donors,
  }) {
    this.donations = donations ?? 0;
    if (donors != null) {
      this.donors = List.from(donors);
    }
  }

  ProjectModel cloneProjectModel() {
    final ProjectModel cloneTo = ProjectModel(
        name: name, description: description, donations: donations);
    cloneTo.donors = donors.toList();
    return cloneTo;
  }

  factory ProjectModel.fromJson(dynamic json) {
    final ProjectModel project = ProjectModel(
      name: json['name'] as String,
      description: json['description'] as String,
      donations: double.parse(json['donations'].toString()),
    );
    if (json['donors'] != null) {
      final list = json['donors'];
      final List<Donors> donors = [];
      for (final donor in list) {
        donors.add(Donors.fromJson(donor));
      }
      project.donors = List.from(donors);
    }
    return project;
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> donorsMap = [];
    for (final Donors donor in donors) {
      final Map<String, dynamic> resMap = donor.toJson();
      donorsMap.add(resMap);
    }
    return {
      'name': name,
      'description': description,
      'donations': donations,
      'donors': donorsMap,
    };
  }
}
