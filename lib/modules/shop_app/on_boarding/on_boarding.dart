import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class OnBoardingScreen extends StatelessWidget {

  List<BoardingModel> boarding =[
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'On board 1 title', body: 'On board 1 body'),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'On board 2 title', body: 'On board 2 body'),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'On board 3 title', body: 'On board 3 body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]) ,
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                Text('Indicator'),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {},
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
