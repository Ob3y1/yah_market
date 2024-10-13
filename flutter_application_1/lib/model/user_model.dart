class UserShow {
  bool? success;
  User? user;
  String? phoneNumber;

  UserShow({this.success, this.user, this.phoneNumber});

  UserShow.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
class User {
  int? id;
  String? name;
  String? dateOfBirth;
  String? gender;


  User(
      {this.id,
      this.name,

      this.dateOfBirth,
      this.gender,
   });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;

    return data;
  }
}