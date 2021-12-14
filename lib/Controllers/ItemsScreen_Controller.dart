

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_getx/models/ItemsModel.dart';


import 'package:get/get.dart';

class ItemScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String categoryId = '';
  String categoryTitle = '';
  List<ItemsModel> itemsData = [];
  List<ItemsModel> searchResults = [];
  bool isloading = true, isSearchLoading = false;
 

  Future<void> getSubCategoryData() async {
    try {
      await _firestore
          .collection('Categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .get()
          .then((value) {
        itemsData =
            value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
        isloading = false;

        update();
      });
    } catch (e) {
      Get.snackbar('oops', e.toString());
    }
  }

  int calDiscount(int totalprice, int sellingprice) {
    double discount = ((totalprice - sellingprice) / totalprice) * 100;
    return discount.toInt();
  }

  Future<void> searchProducts(String query) async {
    if (query.isNotEmpty) {
      isSearchLoading = true;
      Future.delayed(Duration.zero, () {
        update();
      });
      try {
        await _firestore
            .collection('Categories')
            .doc(categoryId)
            .collection(categoryTitle)
            .where('title', isGreaterThanOrEqualTo: query)
            .get()
            .then((value) {
          searchResults =
              value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
          isSearchLoading = false;
          update();
        });
      } catch (e) {}
    }
  }


}
