class Staff {
  final String id;
  final String name;
  final int age;

  Staff({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> data) {
    return Staff(
      id: data['id'],
      name: data['name'],
      age: data['age'],
    );
  }
}
