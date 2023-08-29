class User_modelR {
  String? result;
  String? msg;
  Data? data;

  User_modelR({this.result, this.msg, this.data});

  User_modelR.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? otp;
  String? mobile;
  String? verifyOtp;
  String? userType;

  Data({this.id, this.otp, this.mobile, this.verifyOtp, this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    otp = json['otp'];
    mobile = json['mobile'];
    verifyOtp = json['verify_otp'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['otp'] = this.otp;
    data['mobile'] = this.mobile;
    data['verify_otp'] = this.verifyOtp;
    data['user_type'] = this.userType;
    return data;
  }
}
