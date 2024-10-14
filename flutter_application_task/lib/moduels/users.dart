class Users{
String? name ;
String ?email;
String ?password;
String ?gender;
 DateTime? birthDate;

Users(
  {
  this.name,
   this.email,
    this.password,
     this.gender,
      this.birthDate,
}
);
 factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'birth_date': birthDate?.toIso8601String(), // تحويل إلى String
      'password': password,
    };
  }
}