import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nour/layout/shop_app/cubit/cubit.dart';
import 'package:nour/models/shop_app/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key});

  @override
  Widget build(BuildContext context) {

    return ConditionalBuilder(
      condition:ShopCubit.get(context).homeModel != null,
      builder: (context) {
        return productsBuilder(ShopCubit.get(context).homeModel!);
      },
      fallback: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget productsBuilder(HomeModel model) {
    return Column(
      children: [
        CarouselSlider(
          items: model.data!.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            fit: BoxFit.cover,
            width: double.infinity,
          )).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
