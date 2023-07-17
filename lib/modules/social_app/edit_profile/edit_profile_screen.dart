import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/sharing/icon_broken.dart';
import 'package:nour/sharing/sharing.component/components.dart';

class EditeProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).socialUsersModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).CoverImage;

        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();


        nameController.text=userModel!.name!;
        bioController.text=userModel!.bio!;
        phoneController.text = userModel!.phone!;


        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Edit Profile Screen'
            ),
            titleSpacing: 5.0,
            actions: [
              defaultTextButton(text: 'Update', function:(){
                SocialCubit.get(context).updateUser(
                    phone:phoneController.text ,
                    bio: bioController.text,
                    name: nameController.text
                );
              }),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment:AlignmentDirectional.topEnd ,
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(4.0),topLeft:Radius.circular(4.0)),
                                    image: DecorationImage(
                                        image:coverImage == null
                                            ? NetworkImage('${userModel!.cover}') as ImageProvider<Object>
                                            : FileImage(coverImage) as ImageProvider<Object>,
                                        fit: BoxFit.cover
                                    ),
                                  )
                              ),
                              IconButton(onPressed: (){
                                SocialCubit.get(context).getProfileCover();

                              },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(IconBroken.Camera),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel!.image}') as ImageProvider<Object>
                                    : FileImage(profileImage) as ImageProvider<Object>,
                              ),
                            ),
                            IconButton(onPressed: (){
                              SocialCubit.get(context).getProfileImage();
                            },
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(IconBroken.Camera),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage!=null|| SocialCubit.get(context).CoverImage!=null)
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileImage!=null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: (){
                                    SocialCubit.get(context).uploadProfileImage(
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                        name: nameController.text);
                                  },
                                  text: 'upload profile',
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(
                                height: 5.0,
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )
                      ),
                      SizedBox(width: 5.0,),
                      if(SocialCubit.get(context).CoverImage!=null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: (){
                                    SocialCubit.get(context).uploadCoverImage(
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                        name: nameController.text);
                                  },
                                  text: 'upload cover',
                              ),
                              if(state is SocialUserUpdateLoadingState)

                                SizedBox(
                                height: 5.0,
                              ),
                              if(state is SocialUserUpdateLoadingState)

                                LinearProgressIndicator(),
                            ],
                          )
                        ,)
                      ,

                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value){
                    if(value!.isEmpty){
                    return 'name must\'t be empty';
                    }
                    else
                      return null ;
                      },
                      text: 'Name',
                    prefex: IconBroken.User
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'bio must\'t be empty';
                        }
                        else
                          return null ;
                      },
                      text: 'bio',
                      prefex: IconBroken.Info_Circle
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'phone must\'t be empty';
                        }
                        else
                          return null ;
                      },
                      text: 'phone',
                      prefex: IconBroken.Call
                  )
              ],
              ),
            ),
          ),
        );
      },
    );
  }
}
