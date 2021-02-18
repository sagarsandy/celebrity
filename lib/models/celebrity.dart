class Celebrity {
  final String celebId;
  final String name;
  final int age;
  final String dob;

  Celebrity({this.celebId, this.name, this.age, this.dob});

  factory Celebrity.fromJson(Map<String, dynamic> json) {
    return Celebrity(
      celebId: json["celebId"] as String,
      name: json["name"] as String,
      age: json["age"] as int,
      dob: json["dob"] as String,
    );
  }
}
