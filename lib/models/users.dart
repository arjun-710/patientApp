class Patient {
  String? name;
  String? age;
  String? gender;
  String? roomNum;
  String? ward;
  String? bedNum;

  Patient.fromMap(Map<String, dynamic>? data) {
    name = data?['name'];
    age = data?['age'];
    gender = data?['gender'];
    roomNum = data?['roomNum'];
    ward = data?['ward'];
    bedNum = data?['bedNum'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'roomNum': roomNum,
      'ward': ward,
      'bedNum': bedNum,
    };
  }
}
