import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/sharing/icon_broken.dart';
import 'package:nour/sharing/sharing.component/components.dart';


class NewPostScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var textController =TextEditingController();
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Creat Post'
            ),
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(IconBroken.Arrow___Left_2)),
            actions: [
              defaultTextButton(text: 'Post', function: (){
                var now = DateTime.now();
                if(SocialCubit.get(context).postImage ==null){
                  SocialCubit.get(context).createPost(
                      text: textController.text,
                      dateTime: now.toString());
                }else{
                  SocialCubit.get(context).uploadPostImage(
                      text: textController.text,
                      dateTime: now.toString());
                }
              }),
            ],
          ),
          body: Padding(

            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 20.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                      ) ,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text('Nourhan Al Turk',style: TextStyle(height: 1.4),),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'What is on your mind ..',
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                    alignment:AlignmentDirectional.topEnd ,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 180.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: FileImage(SocialCubit.get(context).postImage!) as ImageProvider<Object> ,
                                fit: BoxFit.cover
                            ),
                          )
                      ),
                      IconButton(onPressed: (){
                       SocialCubit.get(context).removePostImage();

                      },
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5.0,),
                              Text('add photo'),
                            ],
                          )
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Text('# tags')
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
