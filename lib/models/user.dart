class User {
  String? sId;
  String? phoneNumber;
  String? password;
  String? firstName;
  String? lastName;
  String? gender;
  String? maritialStatus;
  String? dob;
  String? otp;
  String? email;
  String? pan;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.sId,
    this.phoneNumber,
    this.password,
    this.firstName,
    this.lastName,
    this.gender,
    this.maritialStatus,
    this.dob,
    this.otp,
    this.email,
    this.pan,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    maritialStatus = json['maritialStatus'];
    dob = json['dob'];
    otp = json['otp'];
    email = json['email'];
    pan = json['pan'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['maritialStatus'] = this.maritialStatus;
    data['dob'] = this.dob;
    data['otp'] = this.otp;
    data['email'] = this.email;
    data['pan'] = this.pan;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
