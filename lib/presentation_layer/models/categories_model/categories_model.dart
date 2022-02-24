class CategoryModel {
  CategoriesDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  List<DataModel> category = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      category.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
