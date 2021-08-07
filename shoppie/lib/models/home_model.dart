class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((value) {
      banners.add(BannersModel.fromJson(value));
    });
    json['products'].forEach((value) {
      products.add(ProductsModel.fromJson(value));
    });
  }
}

class BannersModel {
  int? id;
  String? image;
  CategoryModel? category;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = CategoryModel.fromJson(json['category']);
  }
}

class CategoryModel {
  int? id;
  String? image;
  String? name;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}

class ProductsModel {
  dynamic id, price, oldprice, discount;
  String? image, name;
  bool? inFavourites, inCart;
  List<String>? images = [];
  String? description;
  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
    json['images'].forEach((element) {
      images!.add(element);
    });
    description = json['description'];
  }
}
