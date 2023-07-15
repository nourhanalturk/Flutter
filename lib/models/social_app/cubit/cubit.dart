import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/modules/social_app/chats/chats_screen.dart';
import 'package:nour/modules/social_app/feeds/feeds_screen.dart';
import 'package:nour/modules/social_app/new_post/new_%5Bpost_screen.dart';
import 'package:nour/modules/social_app/settings/settings_screen.dart';
import 'package:nour/modules/social_app/users/users_screen.dart';
import 'package:nour/sharing/sharing.component/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../social_user_model.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super(SocialInitState());
  static SocialCubit get(context) =>BlocProvider.of(context);
  SocialUsersModel? socialUsersModel;
  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          socialUsersModel = SocialUsersModel.fromJson(value.data()!);
          print(value.data());
      emit(SocialGetUserSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));

    });
  }

  int currentIndex =0;
  List<Widget>screens =[
    FeedScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String>titles =[
  'Home',
    'Chats',
    'Post',
    'Users',
    'Settings'
  ];
  void changeBottomNavBar(int index){

    if(index==2)
      emit(SocialNewPostState());
    else {
      currentIndex =index;
      emit(SocialChangeBottomNavBarState());
    }


  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage()async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('no Image selected');
      emit(SocialProfileImagePickedErrorState());

    }
  }
  File? CoverImage;
  Future<void> getProfileCover()async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      CoverImage = File(pickedFile.path);
      emit(SocialProfileCoverPickedSuccessState());
    }else{
      print('no Image selected');
      emit(SocialProfileCoverPickedErrorState());

    }
  }
  void uploadProfileImage( 
      {required phone,
      required bio,
      required name,})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value) {
           // emit(SocialUploadProfileImageSuccessState());
            print(value);
           updateUser(phone: phone, bio: bio, name: name,image: value);
          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());

          });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorState());

    });

  }
  

  void uploadCoverImage(
      {required phone,
        required bio,
        required name,}){
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
       // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(phone: phone, bio: bio, name: name,cover: value);
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());

      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });

  }

//   void updateUserImages({
//     required phone,
//     required bio,
//     required name
// }){
//  emit(SocialUserUpdateLoadingState());
//     if(CoverImage !=null ){
//       uploadCoverImage();
//     }else if(profileImage !=null){
//       uploadProfileImage();
//     }else{
//  updateUser(phone: phone, bio: bio, name: name);
//     }
//
//   }
  void updateUser({
    required phone,
    required bio,
    required name,
    String? cover ,
    String? image
  }){
    SocialUsersModel model = SocialUsersModel(
        phone: phone,
        name: name,
        bio: bio,
        email: socialUsersModel!.email,
        image:image?? socialUsersModel!.image,
        cover: cover??socialUsersModel!.cover,
        uId: socialUsersModel!.uId,
        isEmailVerified: false
    );

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(socialUsersModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(SocialUserUpdateErrorState());
    });
  }
}