import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/cubit/cubit.dart';
import 'package:nour/layout/cubit/states.dart';
import 'package:nour/sharing/sharing.component/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).business;
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  ConditionalBuilder(
          condition: state is !NewsGetBusinessLoadingState,
        builder: (context)
        {
return ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildArticleComponent(list[index]),
    separatorBuilder: (context, index) => Container(width: double.infinity,height: 1.0,color: Colors.grey,),
    itemCount:10,
);
        },
        fallback: (context) {
        return Center(child: CircularProgressIndicator());
        },
        );
      },
    );
  }
}
