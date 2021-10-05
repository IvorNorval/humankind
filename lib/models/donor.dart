class Donor {
  final String donor;

  Donor({
    required this.donor,
  });

  factory Donor.fromJson(dynamic json) {
    final Donor user = Donor(
      donor: json['donor'] as String,
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      'donor': donor,
    };
  }
}
