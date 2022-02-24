class ChangeToFavouriteModel {
  bool? status;
  String? message;

  ChangeToFavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
