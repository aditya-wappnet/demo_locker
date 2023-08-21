class OtpVerificationModel {
  String? message;
  OtpVerificationData? data;

  OtpVerificationModel({this.message, this.data});

  OtpVerificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new OtpVerificationData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OtpVerificationData {
  String? token;

  OtpVerificationData({this.token});

  OtpVerificationData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
