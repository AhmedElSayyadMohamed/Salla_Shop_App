class ShopRegisterModel {
  bool? status;
  String? message;
  UserRegisterDataModel? data;

  ShopRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? UserRegisterDataModel.fromJson(json['data'])
        : null;
  }
}

class UserRegisterDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;
  String? token;
  // UserDataModel({
  //   required this.id,
  //   required this.name,
  //   required this.email,
  //   required this.phone,
  //   required this.image,
  //   required this.point,
  //   required this.credit,
  //   required this.token,
  // });

  //named constructor

  UserRegisterDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }
}
