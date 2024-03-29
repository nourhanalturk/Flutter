import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/models/social_app/message_model.dart';
import 'package:nour/models/social_app/social_user_model.dart';
import 'package:nour/sharing/cubit/cubit.dart';
import 'package:nour/sharing/icon_broken.dart';
import 'package:nour/style/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
SocialUsersModel usersModel;
ChatDetailsScreen({required this.usersModel});
var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      //عشان بدي استدعي اشي قبل ما ال consumer يبدا
           builder: (context) {
             SocialCubit.get(context).getMessages(receiverId: usersModel!.uId);

             return BlocConsumer<SocialCubit,SocialStates>(
  listener: (context, state) {

  },
  builder: (context, state) {
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${usersModel.image!}',

              ) ,

            ),
            SizedBox(width: 15.0,),
            Text(usersModel.name!)

          ],
        ),
      ),
      body: ConditionalBuilder(
        condition:SocialCubit.get(context).messages.length >0 ,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
           Expanded(
             child: ListView.separated(
               physics: BouncingScrollPhysics(),
                 itemBuilder: (context, index) {
                   var message = SocialCubit.get(context).messages[index];
                   if(SocialCubit.get(context).socialUsersModel!.uId ==message.senderID )
                     return buildMyMessage(message);

                   return buildMessage(message);
                 },
                  separatorBuilder: (context, index) => SizedBox(height: 15.0,),
                 itemCount: SocialCubit.get(context).messages.length,
             ),
           ),

              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!,width: 1.0),
                    borderRadius: BorderRadius.circular(15.0)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:textController ,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your message here'
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      color: defaultColor,
                      child: MaterialButton(
                        minWidth: 1.0,
                        onPressed: (){
                          SocialCubit.get(context).sendMessage(
                              receiverId: usersModel.uId,
                              dateTime: DateTime.now(),
                              text: textController.text);
                        },
                        child: Icon(
                          IconBroken.Send,
                          size: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  },
);
           }
        );
  }
  Widget buildMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0
        ),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),

            )
        ),
        child: Text(model.text!)
    ),
  );
  Widget buildMyMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0
        ),
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),

            )
        ),
        child: Text(model.text!)
    ),
  );
}
