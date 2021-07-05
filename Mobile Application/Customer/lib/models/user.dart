class User {
  int id;

  String name;
  String code;
  String email;
  String phone;
  String photo;
  String role;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'] ?? "";
    role = json['role_name'] ?? "client";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'role_name': role,
    };
  }
}
