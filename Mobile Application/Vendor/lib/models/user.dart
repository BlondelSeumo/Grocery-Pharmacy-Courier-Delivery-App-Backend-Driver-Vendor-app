class User {
  int id;
  int vendor_id;
  String name;
  String email;
  String phone;
  String photo;
  String role;
  bool isOnline;

  User({
    this.id,
    this.vendor_id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.role,
    this.isOnline,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor_id = json['vendor_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'] ?? "";
    role = json['role_name'] ?? "client";
    isOnline = json['is_online'] == null ? false : json['is_online'] == 1;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendor_id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'role_name': role,
      'is_online': isOnline,
    };
  }
}
