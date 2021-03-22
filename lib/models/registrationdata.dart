class RegisterData {
  String name = '';
  String phone = '';
  String email = '';

  RegisterData({
    this.name,
    this.phone,
    this.email,
  });

  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['user']['name'];
    phone = json['user']['phone'];
    email = json['user']['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;

    return data;
  }
}
