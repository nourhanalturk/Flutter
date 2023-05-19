import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nour/modules/shop_app/shop_login_screen/shop_login.dart';
import 'package:nour/sharing/sharing.component/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../style/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image ,
    required this.title ,
    required this.body ,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =[
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'On board 1 title', body: 'On board 1 body'),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'On board 2 title', body: 'On board 2 body'),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'On board 3 title', body: 'On board 3 body'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    var boardController =PageController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                  setState(() {
                    isLast = true ;
                  });
                  }else{
                    setState(() {
                      isLast = false ;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]) ,
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 4.0,
                      activeDotColor: defaultColor,
                    ),
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {

                    if(isLast){
                      navigateTo(context, ShopLoginScreen());
                    }else{
                      boardController.nextPage(duration: Duration(microseconds: 750,), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:  [
  Expanded(
  child: Image(
  image: AssetImage('${model.image}'),

  ),
  ),
  SizedBox(
  height: 30.0,
  ),
  Text(
   '${model.title}',
  style: TextStyle(
  fontSize: 24.0,
  ),
  ),
  SizedBox(
  height: 15.0,
  ),
  Text(
  '${model.body}',
  style: TextStyle(
  fontSize: 14.0,
  ),

  ),
    SizedBox(
      height: 30.0,
    ),
  ],
  );
}
