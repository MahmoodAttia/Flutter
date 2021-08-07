class LoginModel {
  bool? status;
  String? message;
  LoginData? data;
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] == null ? null : LoginData.fromJson(json['data']);
  }
}

class LoginData {
  String? name;
  String? email;
  String? phone;
  String? token;

  LoginData.fromJson(Map<String, dynamic> json) {
    name = json['name']!;
    email = json['email']!;
    phone = json['phone']!;
    token = json['token']!;
  }
}
