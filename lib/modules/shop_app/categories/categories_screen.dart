import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/cubit/cubit.dart';
import 'package:nour/layout/shop_app/cubit/states.dart';
import 'package:nour/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => BuildCategoriesItems(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Container(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length
        );
      },
    );
  }
}

Widget BuildCategoriesItems(DataModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        width: 80.0,
        height: 80.0,
        image: NetworkImage(model.image!),
        fit: BoxFit.cover,
      ),
      SizedBox(width: 10.0,),
      Text(
          model.name!
      ),
      Spacer(),
      Icon(
          Icons.arrow_forward_ios
      )
    ],
  ),
);
