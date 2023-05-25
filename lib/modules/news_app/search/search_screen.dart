import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/sharing/sharing.component/components.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';

class SearchScreen extends StatelessWidget {

var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: Text('Search Screen',),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if(value!.isEmpty)
                      {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    text: 'search',
                    prefex: Icons.search,
                    onChange: (value){
                        NewsCubit.get(context).getSearch(value);
                    }
                ),
              ),
              Expanded(child: articleBuilder(list, context)),
            ],
          ),
        );
      },
    );
  }
}
