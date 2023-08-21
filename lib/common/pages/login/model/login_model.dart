class LoginModel {
  String? message;
  LoginData? data;

  LoginModel({this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? token;
  User? user;

  LoginData({this.token, this.user});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  dynamic countryCode;
  String? profileImage;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? status;
  bool? pushNotificationSetting;
  String? fullProfileImage;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.countryCode,
      this.profileImage,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.userType,
      this.status,
      this.pushNotificationSetting,
      this.fullProfileImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    profileImage = json['profile_image'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    status = json['status'];
    pushNotificationSetting = json['push_notification_setting'];
    fullProfileImage = json['full_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['country_code'] = countryCode;
    data['profile_image'] = profileImage;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_type'] = userType;
    data['status'] = status;
    data['push_notification_setting'] = pushNotificationSetting;
    data['full_profile_image'] = fullProfileImage;
    return data;
  }
}
