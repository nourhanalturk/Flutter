import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/models/social_app/message_model.dart';
import 'package:nour/modules/social_app/chats/chats_screen.dart';
import 'package:nour/modules/social_app/feeds/feeds_screen.dart';
import 'package:nour/modules/social_app/settings/settings_screen.dart';
import 'package:nour/modules/social_app/users/users_screen.dart';
import 'package:nour/sharing/sharing.component/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../../../modules/social_app/new_post/new_post_screen.dart';
import '../post_model.dart';
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
   if(index ==1)
   getAllUsers();
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

  File? postImage;
 // final picker = ImagePicker();
  Future<void> getPostImage()async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else{
      print('no Image selected');
      emit(SocialPostImagePickedErrorState());

    }
  }
 void removePostImage(){
   postImage =null ;
   emit(SocialRemovePostImageState());
 }

  void uploadPostImage(
      {
        required text,
        required dateTime,

      })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
         value.ref.getDownloadURL()
         .then((value) {
           createPost(text: text, dateTime: dateTime,postImage: value);
        print(value);
      }).catchError((error){
        emit(SocialCreatePostErrorState());

      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());

    });

  }

  void createPost({

    required text,
    required dateTime,
    String? postImage
  }){
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
        name: socialUsersModel!.name,
        image:socialUsersModel!.image,
        uId: socialUsersModel!.uId,
        text: text,
        dateTime: dateTime,
      postImage: postImage??''
    );

    FirebaseFirestore
        .instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());

    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts =[];
  List<String> postId =[];
  List<int> likes =[];

  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value){
          value.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
                  likes.add(value.docs.length);
              postId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
                .catchError((error){});

          });
      emit(SocialGetPostsSuccessState());

    })
        .catchError((error){
          emit(SocialGetPostsErrorState(error.toString()));
    });
  }
  void likePost(String postId){
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(socialUsersModel!.uId)
          .set({
        'like':true
          })
          .then((value) {
            emit(SocialLikePostSuccessState());
      })
          .catchError((error){
        emit(SocialLikePostErrorState(error.toString()));

      });
  }
  List<SocialUsersModel> users =[] ;
  void getAllUsers(){
    if(users.length==0)
    FirebaseFirestore.instance
         .collection('users')
        .get()
        .then((value){
      value.docs.forEach((element) {
        if(element.data()['uId']!=socialUsersModel!.uId)
        users.add(SocialUsersModel.fromJson(element.data()));
        });
      emit(SocialGetAllUserSuccessState());

    })
        .catchError((error){
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }
  void sendMessage({
    required receiverId,
    required dateTime,
    required text
}){

    MessageModel messageModel =MessageModel(
      dateTime: dateTime,
      senderID: socialUsersModel!.uId,
      receiverID: receiverId,
      text: text,
    );
    //set my Chats
    FirebaseFirestore.instance
         .collection('users')
         .doc(socialUsersModel!.uId)
         .collection('chats')
         .doc(receiverId)
         .collection('messages')
         .add(messageModel.toMap())
         .then((value) {
           emit(SocialSendMessageSuccessState());
    })
         .catchError((error){
      emit(SocialSendMessageErrorState());

    });
    //set receiver Chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(socialUsersModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());

    });
  }

  List<MessageModel> messages =[];
  void getMessages({
    required receiverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialUsersModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          // in listen the data will get all the messages
      messages =[];
          //event is the message
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
}

//snapshots is a real time or future query its always open and then we listen to the changes
}