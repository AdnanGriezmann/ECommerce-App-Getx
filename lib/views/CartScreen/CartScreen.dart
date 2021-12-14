import 'package:ecommerce_app_getx/Controllers/CardScreen_Controller.dart';
import 'package:ecommerce_app_getx/models/ItemsDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final controller = Get.put(CartScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(child: GetBuilder<CartScreenController>(builder: (value) {
        if (!controller.isLoading) {
          return Scaffold(
            appBar: NewGradientAppBar(
              title: Text('My CART'),
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.red]),
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                  itemCount: controller.productsDetails.length,
                  itemBuilder: (context, index) {
                    return CartItems(size, controller.productsDetails[index]);
                  }),
            ),
            bottomNavigationBar: SizedBox(
              height: size.height / 12,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rs. 100202',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: size.height / 18,
                      width: size.width / 2.6,
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text(
                        'CheckOut',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      })),
    );
  }

  Widget CartItems(Size size, ItemDetailModel model) {
    int discount =
        controller.calculateDiscount(model.sellingPrice, model.totalPrice);
    return Container(
      height: size.height / 4,
      width: size.width / 1.05,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Container(
                height: size.height / 8,
                width: size.width / 4.5,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(model.img)),
                      ),
                    ),
                    SizedBox(width: size.width / 18),
                    Expanded(
                      child: SizedBox(
                        child: RichText(
                          text: TextSpan(
                            text: '${model.title}\n',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                text: '${model.totalPrice}\t',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              TextSpan(
                                  text: '${model.sellingPrice}\t',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              TextSpan(
                                  text: '${discount}% off',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            'Will be Delivered in ${model.deliverysDays} days',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w300, fontSize: 20),
          ),
          ListTile(
            onTap: () {
              controller.removeFromCart(model.id);
            },
            title: Text('Remove from Cart'),
            trailing: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
