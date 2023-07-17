import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/models/social_app/cubit/states.dart';
import 'package:nour/models/social_app/post_model.dart';
import 'package:nour/sharing/icon_broken.dart';
import 'package:nour/style/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).socialUsersModel !=null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image:NetworkImage(
                          'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                        ) ,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200.0,
                      ),
                      Text(
                        'Communication with friends',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context, index) => SizedBox(height: 10.0,),
                  itemCount: SocialCubit.get(context).posts.length,
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildPostItem (PostModel model,context,index){
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 2,
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${model.image}'
                    ) ,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${model.name}',style: TextStyle(height: 1.4),),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(Icons.check_circle,color: defaultColor,size: 16.0,)
                          ],
                        ),
                        Text('${model.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4),)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      ))
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                  '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0,bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          child:Text(
                              '#softwaare',
                              style: Theme.of(context).textTheme.caption!.copyWith(  color: defaultColor)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                    width: double.infinity,
                    height: 140.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              '${model.postImage}'
                          ) ,
                          fit: BoxFit.cover
                      ),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(IconBroken.Heart,size: 16.0,color: Colors.red,),
                              SizedBox(width: 5.0,),
                              Text('${SocialCubit.get(context).likes[index]}',style: Theme.of(context).textTheme.caption,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(IconBroken.Chat,size: 16.0,color: Colors.amber,),
                              SizedBox(width: 5.0,),
                              Text('0 comment',style: Theme.of(context).textTheme.caption,)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1.0,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(

                                '${SocialCubit.get(context).socialUsersModel!.image}'
                            ) ,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text('write a comment...',
                            style: Theme.of(context).textTheme.caption!,)

                        ],
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(IconBroken.Heart,size: 16.0,color: Colors.red,),
                        SizedBox(width: 5.0,),
                        Text('likes',style: Theme.of(context).textTheme.caption,)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
