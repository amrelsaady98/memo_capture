class User {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? token;

  User({this.id, this.name, this.email, this.mobileNumber, this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['token'] = this.token;
    return data;
  }
}
