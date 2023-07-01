import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/shop_app/favorites_model.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => BuildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
            separatorBuilder: (context, index) => Container(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
        );
      },
    );
  }

  Widget BuildFavItem(FavoriteData model,context) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
  height: 120.0,

  child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Stack(
  alignment: AlignmentDirectional.bottomStart,
  children: [
  Image.network(
  model.product!.image!,
  height: 120.0,
  fit: BoxFit.cover,
  width: 120.0,
  ),
  if(model.product!.discount!=0)
  Container(
  padding: const EdgeInsetsDirectional.symmetric(horizontal: 5.0),
  color: Colors.red,
  child: const Text(
    'DISCOUNT',
    style: TextStyle(color: Colors.white,fontSize: 8.0),),
  )
  ],
  ) ,
  Container(
    width: 15.0,
  ),
  Expanded(
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  model.product!.name!,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  style: const TextStyle(
  fontSize: 14.0,
  height: 1.3,
  ),
  ),
  Spacer(),
  Row(
  children: [
  Text(
    model.product!.price!.toString(),
  style: const TextStyle(
  fontSize: 14.0,
  height: 1.3,
  color: defaultColor,
  ),
  ),
  const SizedBox(
  width: 10.0,
  ),
  if(1!=0)
  Text(
    model.product!.oldPrice!.toString(),
  style: const TextStyle(
  fontSize: 14.0,
  height: 1.3,
  color: Colors.grey,
  decoration: TextDecoration.lineThrough,
  ),
  ),
  const Spacer(),
  IconButton(
  onPressed: () {
  ShopCubit.get(context).changeFavorites(model.product!.id!);
  },

  icon: CircleAvatar(
  radius: 15.0,
  backgroundColor: ShopCubit.get(context)!.favorites[model.product!.id!]!
  ? defaultColor
      : Colors.grey,
  child: const Icon(
  Icons.favorite_border,
  size: 14.0,
  color: Colors.white,
  )
  ),

  ),
  ],
  ),
  ],
  ),
  ),


  ],
  ),
  ),
  );
}
