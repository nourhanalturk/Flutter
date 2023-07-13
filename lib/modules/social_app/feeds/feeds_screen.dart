import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nour/sharing/icon_broken.dart';
import 'package:nour/style/colors.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => SizedBox(height: 10.0,),
            itemCount: 10,
          )
        ],
      ),
    );
  }
  Widget buildPostItem (context){
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 2,
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Nourhan Al Turk',style: TextStyle(height: 1.4),),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(Icons.check_circle,color: defaultColor,size: 16.0,)
                          ],
                        ),
                        Text('January 21 ,2023 at 11:00am',style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4),)
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
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
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
              Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                        ) ,
                        fit: BoxFit.cover
                    ),
                  )
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
                              Text('1200',style: Theme.of(context).textTheme.caption,)
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
                              Text('120 comment',style: Theme.of(context).textTheme.caption,)
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
                              'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
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
                    onTap: () {},
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
