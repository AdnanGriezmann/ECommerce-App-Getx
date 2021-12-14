import 'package:ecommerce_app_getx/Controllers/HomeScreen_Controller.dart';
import 'package:ecommerce_app_getx/models/Catmodel.dart';
import 'package:ecommerce_app_getx/views/CartScreen/CartScreen.dart';
import 'package:ecommerce_app_getx/views/Categories_Featured/categories_feature_screen.dart';
import 'package:ecommerce_app_getx/views/Home/drawer.dart';
import 'package:ecommerce_app_getx/views/ItemScreen/ItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    final controller = Get.put(HomeScreenController());
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: GetBuilder<HomeScreenController>(
          builder: (value) {
            if (!value.isloading) {
              return Scaffold(
                appBar: NewGradientAppBar(
                  title: Text('E-Commerce App'),
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
                drawer: HomeDrawer(),
                body: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      //Banner..........
                      SizedBox(
                        height: size.height / 3.4,
                        width: size.width,
                        child: PageView.builder(
                          onPageChanged: controller.changeIndicator,
                          itemCount: controller.bannerData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                      controller.bannerData[index].image),
                                )),
                              ),
                            );
                          },
                        ),
                      ),
                      //Indicator..............
                      SizedBox(
                        height: size.height / 42,
                        width: size.width,
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < controller.isSelected.length;
                                  i++)
                                indicator(size, controller.isSelected[i].value)
                            ],
                          );
                        }),
                      ),

                      //Categories...........

                      categoriedTitle(size, 'All Categories', () {
                        Get.to(() => CategoriesAndFeature(
                            model: controller.categoriesData));
                      }),
                      SizedBox(height: 8.0),

                      listViewBuilder(size, controller.categoriesData),
                      SizedBox(height: 8.0),
                      categoriedTitle(size, 'Featured', () {
                        Get.to(() => CategoriesAndFeature(
                            model: controller.featuredData));
                      }),
                      listViewBuilder(size, controller.featuredData),
                    ]),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget listViewBuilder(Size size, List<CategoriesModel> data) {
    return SizedBox(
      height: size.height / 9,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return listViewBuilderItems(size, data[index]);
          }),
    );
  }

  Widget listViewBuilderItems(Size size, CategoriesModel categories) {
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
              height: size.height / 13,
              width: size.width / 2.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(categories.image),
                ),
              ),
            ),
            SizedBox(
              child: Text(
                categories.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoriedTitle(Size size, String title, Function func) {
    return SizedBox(
      height: size.height / 17,
      width: size.width / 1.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blue),
            onPressed: () => func(),
            child: Text(
              'View More',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget indicator(Size size, bool iselected) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: iselected ? size.height / 80 : size.height / 100,
        width: iselected ? size.height / 80 : size.height / 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}
