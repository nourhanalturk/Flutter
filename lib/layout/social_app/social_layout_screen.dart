import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/sharing/sharing.component/components.dart';
import 'package:toast/toast.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('News Feed'),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).socialUsersModel!=null,
            builder: (context) {
              var model =SocialCubit.get(context).socialUsersModel;
             if( model?.isEmailVerified == false) {
               return Column(
                 children: [
                   Container(
                     height: 75.0,
                     color: Colors.amber.withOpacity(0.6),
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Row(
                         children: [
                           Icon(Icons.info_outline),
                           SizedBox(
                             width: 15.0,
                           ),
                           Expanded(child: Text('please verify you email')),
                           defaultTextButton(function: () {
                             FirebaseAuth.instance.currentUser!.sendEmailVerification()
                                 .then((value) {
                               ToastContext toastContext = ToastContext();
                               toastContext.init(context);
                               Toast.show('check your mail',backgroundColor: Colors.green,duration: Toast.lengthLong );

                             })
                                 .catchError((error){});
                           }, text: 'sent ',)
                         ],
                       ),
                     ),
                   ),
                 ],
               );
             }else{
               return Center(child: CircularProgressIndicator());
             }
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
