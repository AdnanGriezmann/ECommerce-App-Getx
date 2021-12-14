import 'package:ecommerce_app_getx/Controllers/ItemsDetail_Controllers.dart';
import 'package:ecommerce_app_getx/views/CartScreen/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

// ignore: must_be_immutable
class ItemDetailScreen extends StatelessWidget {

  String id;
  ItemDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final controller = Get.put(ItemDetailController());

    controller.getItemDetails(id);
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: GetBuilder<ItemDetailController>(builder: (value) {
          if (!controller.isloading) {
            return Scaffold(
              appBar: NewGradientAppBar(
                title: Text('Detail'),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple, Colors.red]),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => CartScreen());
                      },
                      icon: Icon(Icons.shopping_cart)),
                ],
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 3.4,
                        width: size.width,
                        child: PageView.builder(
                          // onPageChanged: controller.changeIndicator,
                          itemCount: controller.model.banners.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                      controller.model.banners[index]),
                                  fit: BoxFit.fitWidth,
                                )),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: size.height / 25),
                      SizedBox(
                        width: size.width / 1.1,
                        child: Text(
                          controller.model.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      SizedBox(height: size.height / 25),
                      SizedBox(
                        width: size.width / 1.1,
                        child: RichText(
                          text: TextSpan(
                            text: '${controller.model.totalPrice}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough),
                            children: [
                              TextSpan(
                                  text: '${controller.model.sellingPrice}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      decoration: TextDecoration.none)),
                              TextSpan(
                                  text: '${controller.discount}% off',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height / 19),
                      SizedBox(
                        width: size.width / 1.1,
                        child: Text(
                          controller.model.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ),
                      SizedBox(height: size.height / 19),
                      ListTile(
                        onTap: () {},
                        title: Text('See Reviews'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Icon(Icons.star),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: size.height / 14,
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: customButton(size, () {
                      if (controller.isAlreadyAvail) {
                        Get.to(() => CartScreen());
                      } else {
                        controller.addItemsToCart();
                      }
                    },
                            Colors.blue,
                            controller.isAlreadyAvail
                                ? 'Go to Cart'
                                : 'Add to Cart')),
                    Expanded(
                        child:
                            customButton(size, () {}, Colors.white, 'Buy Now')),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Widget customButton(Size size, Function func, Color colr, String title) {
    return GestureDetector(
      onTap: () => func(),
      child: Container(
        alignment: Alignment.center,
        color: colr,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: colr == Colors.blue ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
