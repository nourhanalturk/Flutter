import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/cubit/states.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../models/shop_app/home_model.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: productsBuilder(ShopCubit.get(context).homeModel!),
                  ),
                );
              },
            );
          },
          fallback: (context) {
            return Center(child: CircularProgressIndicator());
          },
        );
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
        const SizedBox(
          height: 10.0,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1/1.2,
          children: List.generate(
            model.data!.products.length,
                (index) => BuildGridProduct(model.data!.products[index]),
          ),
        ),
      ],
    );
  }

  Widget BuildGridProduct(ProductsModel model) => Column(
    children: [
      model.image != null
          ? Image.network(
        model.image!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200.0,
      )
          : Container(),
    ],
  );
}


