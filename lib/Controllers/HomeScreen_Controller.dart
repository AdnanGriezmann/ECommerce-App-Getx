import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_getx/models/Bannermodel.dart';
import 'package:ecommerce_app_getx/models/Catmodel.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<BannerDataModel> bannerData;
  late List<CategoriesModel> categoriesData;
  late List<CategoriesModel> featuredData;
  bool isloading = true;
  List<RxBool> isSelected = [];

  void getAllData() async {
    await Future.wait([
      getBannerData(),
      getAllCategories(),
      getFeatureData(),
    ]).then((value) {
     
      isloading = false;
      update();
    });
  }

  void changeIndicator(int index) {
    isSelected[index].value = true;
     for (var i = 0; i < isSelected.length; i++) {
      if (isSelected[i].value) {
        isSelected[i].value = false;
      }
    }
  }

  Future<void> getBannerData() async {
    await _firestore.collection('banner').get().then((value) {
      bannerData =
          value.docs.map((e) => BannerDataModel.fromJson(e.data())).toList();
      for (var i = 0; i < bannerData.length; i++) {
        isSelected.add(false.obs);
      }
      isSelected[0].value = true;
    });
  }

  Future<void> getAllCategories() async {
    await _firestore.collection('Categories').get().then((value) {
      categoriesData =
          value.docs.map((e) => CategoriesModel.fromJson(e.data())).toList();
    });
  }

  Future<void> getFeatureData() async {
    await _firestore.collection('Featured').get().then((value) {
      featuredData =
          value.docs.map((e) => CategoriesModel.fromJson(e.data())).toList();
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAllData();
  }
}
