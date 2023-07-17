import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:nour/sharing/icon_broken.dart';
import 'package:nour/sharing/sharing.component/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).socialUsersModel;
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight:Radius.circular(4.0),topLeft:Radius.circular(4.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${userModel!.cover}'
                                ) ,
                                fit: BoxFit.cover
                            ),
                          )
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            '${userModel!.image}'
                        ) ,
                      ),
                    ),
                  ],
                ),
              ),
              Text(  '${userModel!.name}',style:Theme.of(context).textTheme.bodyText1),
              Text(  '${userModel!.bio}',style:Theme.of(context).textTheme.caption),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100 ',style:Theme.of(context).textTheme.subtitle2),
                            Text('Posts',style:Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('45',style:Theme.of(context).textTheme.subtitle2),
                            Text('followers',style:Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('12 ',style:Theme.of(context).textTheme.subtitle2),
                            Text('Following',style:Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100 ',style:Theme.of(context).textTheme.subtitle2),
                            Text('photos',style:Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child:OutlinedButton(
                    onPressed: () {

                    },
                    child:Text('Add photo') ,
                  ) ),
                  SizedBox(
                    width: 5.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                     navigateTo(context, EditeProfileScreen());
                    },
                    child:Icon(
                      IconBroken.Edit
                    ),
                  ),
                    ],
              )
            ],
          ),
        );
      },
    );
  }
}
