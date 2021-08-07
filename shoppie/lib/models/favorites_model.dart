class FavouritesModel {
  bool? status;
  Data? data;

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = new Data.fromJson(json['data']);
  }
}

class Data {
  List<FavProductData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add(new FavProductData.fromJson(v));
    });
  }
}

class FavProductData {
  int? id;
  ProductDataD? product;

  FavProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = new ProductDataD.fromJson(json['product']);
  }
}

class ProductDataD {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  ProductDataD.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
