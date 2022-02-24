class FavouriteModel {
  bool? status;
  DataModel? data;

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }
}

class DataModel {
  int? currentPage;
  List<Data> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((e) {
        data.add(Data.fromJson(e));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class Data {
  int? id;
  ProductModel? product;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
