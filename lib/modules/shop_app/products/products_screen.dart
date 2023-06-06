import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/cubit/states.dart';
import 'package:nour/models/shop_app/categories_model.dart';
import 'package:nour/style/colors.dart';

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
          condition: ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriesModel != null,
          builder: (context) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!),
                  ),
                );
              },
            );
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800
                  ),
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder:(context, index) =>  buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(width: 15.0,),
                      itemCount:categoriesModel.data!.data.length,
                  ),
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.6,
              children: List.generate(
                model.data!.products.length,
                    (index) => BuildGridProduct(model.data!.products[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildCategoryItem(DataModel model)=>Container(
    height: 100.0,
    width: 100.0,

    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
         Image(
          image: NetworkImage(
            model.image!,
          ),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(.7),
          child:  Text(
            model.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  Widget BuildGridProduct(ProductsModel model) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        model.image != null ?
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image.network(
              model.image!,
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount!=0)
            Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 5.0),
              color: Colors.red,
              child: const Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 8.0),),
            )
          ],
        ) :
        Container(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if(model.discount!=0)
                  Text(
                    '${model.old_price}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ],
          ),
        ),


      ],
    ),
  );
}


