import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/models/social_app/social_user_model.dart';
import 'package:nour/modules/social_app/chat_details/chat_details.dart';
import 'package:nour/sharing/sharing.component/components.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length >0 ,
          builder: (context) =>ListView.separated(
            itemBuilder: (BuildContext context, int index) => buildChatItem(SocialCubit.get(context).users[index]!,context) ,
            separatorBuilder: (BuildContext context, int index) => Container(height: 1.0,width: double.infinity,color: Colors.grey[300],) ,
            itemCount: SocialCubit.get(context).users.length,

          ) ,
          fallback: (context) => Center(child: CircularProgressIndicator()),


        );

      },
    );
  }
  Widget buildChatItem(SocialUsersModel model,context)=>  InkWell(
    onTap: (){
     navigateTo(context, ChatDetailsScreen(usersModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',

            ) ,

          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',style: TextStyle(height: 1.4),),

        ],
      ),
    ),
  );
}
