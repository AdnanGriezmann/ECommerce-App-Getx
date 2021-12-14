
// ignore_for_file: must_be_immutable

import 'package:ecommerce_app_getx/models/Catmodel.dart';
import 'package:ecommerce_app_getx/views/ItemScreen/ItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CategoriesAndFeature extends StatelessWidget {
  List<CategoriesModel> model;

  CategoriesAndFeature({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          appBar: NewGradientAppBar(
            title: Text('All Categories'),
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.red]),
          ),
          body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: GridView.builder(
                itemCount: model.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GridViewBuilderItems(Get.size, model[index]);
                }),
          ),
        ),
      ),
    );
  }

  Widget GridViewBuilderItems(Size size, CategoriesModel categories) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ItemsScreen(
          categoryId: categories.id,
          categoryTitle: categories.title,
        ));
      },
      child: Container(
        height: size.height / 11,
        width: size.width / 2.8,
        child: Column(
          children: [
            Container(
              height: size.height / 11,
              width: size.width / 2.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(categories.image),
                ),
              ),
            ),
            SizedBox(height: 4.0),
            SizedBox(
              child: Text(
                categories.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
