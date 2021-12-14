import 'package:ecommerce_app_getx/Controllers/ItemsScreen_Controller.dart';
import 'package:ecommerce_app_getx/models/ItemsModel.dart';
import 'package:ecommerce_app_getx/views/itemdetail/ItemdetailScreen.dart';
import 'package:ecommerce_app_getx/views/searchdelegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ItemsScreen extends StatelessWidget {
  final Size size = Get.size;

  final String categoryId, categoryTitle;
  ItemsScreen({required this.categoryId, required this.categoryTitle});

  final controller = Get.put(ItemScreenController());

  @override
  Widget build(BuildContext context) {
    controller.categoryTitle = categoryTitle;
    controller.categoryId = categoryId;
    controller.getSubCategoryData();

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          appBar: NewGradientAppBar(
            title: Text(categoryTitle),
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.red]),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(height: size.height / 40),
                SearchBar(size,context),
                Expanded(
                  child: SizedBox(
                    child: GetBuilder<ItemScreenController>(
                      builder: (value) {
                        if (!value.isloading) {
                          return ListView.builder(
                          
                            itemCount: value.itemsData.length,
                            itemBuilder: (context, index) {
                              return listViewBuilderItems(
                                  size, value.itemsData[index]);
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listViewBuilderItems(Size size, ItemsModel model) {
    int discount = controller.calDiscount(model.totalPrice, model.sellingPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.to(()=>ItemDetailScreen(
              id: model.detailid,

          ));
        },
        child: Container(
          height: size.height / 8,
          width: size.width / 4.5,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(model.image)),
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
                                color: Colors.black)),
                        TextSpan(
                            text: '${model.sellingPrice}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        TextSpan(
                            text: '$discount% off',
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
    );
  }

  Widget SearchBar(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: SearchScreen());
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(11),
        color: Colors.grey[300],
        child: Container(
          height: size.height / 15,
          width: size.width / 1.1,
          padding: EdgeInsets.symmetric(horizontal: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Here...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }
}
