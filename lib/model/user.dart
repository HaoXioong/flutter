class VerifyAccount {
  int status;

  VerifyAccount({this.status});

  VerifyAccount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class Login {
  int status;
  int uid;
  String token;
  String refresh;
  String email;
  String phone;
  String nickname;
  int tp;
  int lastLogin;

  Login(
      {this.status,
      this.uid,
      this.token,
      this.refresh,
      this.email,
      this.phone,
      this.nickname,
      this.tp,
      this.lastLogin});

  Login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    uid = json['uid'];
    token = json['token'];
    refresh = json['refresh'];
    email = json['email'];
    phone = json['phone'];
    nickname = json['nickname'];
    tp = json['tp'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['refresh'] = this.refresh;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['nickname'] = this.nickname;
    data['tp'] = this.tp;
    data['last_login'] = this.lastLogin;
    return data;
  }
}
