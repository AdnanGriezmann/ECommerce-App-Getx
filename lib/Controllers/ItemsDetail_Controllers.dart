import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_getx/models/ItemsDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ItemDetailController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloading = true, isAlreadyAvail = false;
  late ItemDetailModel model;
  int discount = 0;

  Future<void> getItemDetails(String id) async {
    try {
      await _firestore.collection('products').doc(id).get().then((value) {
        model = ItemDetailModel.fromjson(value.data()!);
        discount = calDiscount(model.totalPrice, model.sellingPrice);
        chectAlready();
      });
    } catch (e) {}
  }

  int calDiscount(int totalprice, int sellingprice) {
    double discount = ((totalprice - sellingprice) / totalprice) * 100;
    return discount.toInt();
  }

  Future<void> chectAlready() async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .where('id', isEqualTo: model.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isAlreadyAvail = true;
        }
        isloading = false;
        update();
      });
    } catch (e) {}
  }

  Future<void> addItemsToCart() async {
    isloading = true;
    update();
    try {
      await _firestore
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(model.id)
          .set({
        'id': model.id,
      }).then((value) {
        chectAlready();
      });
    } catch (e) {}
  }
}
