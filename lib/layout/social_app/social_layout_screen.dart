import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/sharing/icon_broken.dart';
import 'package:nour/sharing/sharing.component/components.dart';
import 'package:toast/toast.dart';

import '../../modules/social_app/new_post/new_post_screen.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
if(state is SocialNewPostState){
  navigateTo(context, NewPostScreen());
}
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: ''
              )
            ],
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeBottomNavBar(value);
            },
          ),

          // body:
        );
      },
    );
  }
}






// ConditionalBuilder(
//   condition: SocialCubit.get(context).socialUsersModel!=null,
//   builder: (context) {
//     var model =SocialCubit.get(context).socialUsersModel;
//    if( model?.isEmailVerified == false) {
//      return Column(
//        children: [
//          Container(
//            height: 75.0,
//            color: Colors.amber.withOpacity(0.6),
//            child: Padding(
//              padding: const EdgeInsets.all(20.0),
//              child: Row(
//                children: [
//                  Icon(Icons.info_outline),
//                  SizedBox(
//                    width: 15.0,
//                  ),
//                  Expanded(child: Text('please verify you email')),
//                  defaultTextButton(function: () {
//                    FirebaseAuth.instance.currentUser!.sendEmailVerification()
//                        .then((value) {
//                      ToastContext toastContext = ToastContext();
//                      toastContext.init(context);
//                      Toast.show('check your mail',backgroundColor: Colors.green,duration: Toast.lengthLong );
//
//                    })
//                        .catchError((error){});
//                  }, text: 'sent ',)
//                ],
//              ),
//            ),
//          ),
//        ],
//      );
//    }else{
//      return Center(child: CircularProgressIndicator());
//    }
//   },
//   fallback: (context) => Center(child: CircularProgressIndicator()),
// ),