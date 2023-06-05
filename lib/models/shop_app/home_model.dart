class HomeModel{
  bool? status ;
  HomeDataModel? data ;

  HomeModel.fromJson(Map<String ,dynamic>json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }

}
class HomeDataModel {
  List <BannerModel>banners =[];
  List <ProductsModel>products =[];
HomeDataModel.fromJson(Map<String ,dynamic>json){
json['banners'].forEach((element) {
  banners.add(BannerModel.fromJson(element));
});

json['products'].forEach((element) {
  products.add(ProductsModel.fromJson(element));
});
}

}

class BannerModel {
  int? id ;
  String? image;
  BannerModel.fromJson(Map<String ,dynamic>json){
  id = json['id'];
  image = json['image'];
  }
}
class ProductsModel {
  int? id;
  dynamic? price ;
  dynamic? old_price;
  dynamic? discount;
  bool? in_favorites;
  bool? in_cart;
  String? image;
  String? name;


  ProductsModel.fromJson(Map<String ,dynamic>json){
    id=json['id'];
    old_price = json['old_price'];
    discount = json['discount'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
  }
}