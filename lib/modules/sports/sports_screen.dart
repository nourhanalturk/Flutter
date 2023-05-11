import 'package:flutter/cupertino.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'SportScreen',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}