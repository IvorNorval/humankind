class ProjectModel {
  final String name;
  final String description;
  late double donations;

  ProjectModel({
    required this.name,
    required this.description,
    double? donations,
  }) {
    this.donations = donations ?? 0;
  }

  ProjectModel cloneProjectModel() {
    final ProjectModel cloneTo = ProjectModel(
        name: name, description: description, donations: donations);
    return cloneTo;
  }

  factory ProjectModel.fromJson(dynamic json) {
    final ProjectModel project = ProjectModel(
      name: json['name'] as String,
      description: json['description'] as String,
      donations: double.parse(json['donations'].toString()),
    );
    return project;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'donations': donations,
    };
  }
}
