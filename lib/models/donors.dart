class Donors {
  final String donor;

  Donors({
    required this.donor,
  });

  factory Donors.fromJson(dynamic json) {
    final Donors user = Donors(
      donor: json['name'] as String,
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      'donor': donor,
    };
  }
}
