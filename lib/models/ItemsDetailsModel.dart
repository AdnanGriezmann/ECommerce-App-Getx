class ItemDetailModel {
  late String id, title, img, deliverysDays, description;
  late List banners;
  late int sellingPrice, totalPrice;

  ItemDetailModel(
      {required this.banners,
      required this.id,
      required this.img,
      required this.sellingPrice,
      required this.totalPrice,
      required this.title,
      required this.deliverysDays,
      required this.description});

  ItemDetailModel.fromjson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    img = map['img'];
    deliverysDays = map['delivery_days'];
    description = map['des'];
    banners = map['banners'];
    sellingPrice = map['sell_price'];
    totalPrice = map['total_price'];
  }
}
