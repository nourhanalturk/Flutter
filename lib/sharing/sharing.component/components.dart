

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nour/sharing/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
   Color color = Colors.blue,
  required  Function function ,
  required String text ,
}) =>  Container(
  width: width,
  color: color,
  child: MaterialButton(
    onPressed:(){
      function();
  },
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);


Widget defaultFormField ({
 required TextEditingController controller ,
  required TextInputType type ,
  Function? onSubmit ,
  Function? onChange,
  bool isPassword =false,
  required Function(String? s) validate,
  required String text,
  required IconData prefex,
  IconData? suffex,
  Function? suffexPass ,
   Function? ontap,

}){
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: type,
    onFieldSubmitted:(s){
      onSubmit!(s);
    },
    onChanged:(s){
      onChange!(s);
    },
    validator: (String? v){
    return validate(v);
    },
    onTap:(){
      return ontap!();
    },

    decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(
        prefex,
      ),
      suffixIcon: suffex != null ?IconButton(
        onPressed: (){
          return suffexPass!();
        },
        icon: Icon(
         suffex,
        ),
      ) :null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget buildTaskItem (Map model,context)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    children: [
      CircleAvatar(
        radius:40.0 ,
        child: Text(
            '${model['time']}'
        ),


      ),
      const SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model['title']}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${model['date']}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

          ],
        ),
      ),
      const SizedBox(
        width: 10.0,
      ),
      IconButton(
        onPressed: () {
          AppCubit.get(context).updateDatabase(
              status: 'done',
              id:model['id'] ,
          );
        },
        icon:const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),


      ),
      IconButton(
        onPressed: () {
          AppCubit.get(context).updateDatabase(
            status: 'archived',
            id:model['id'] ,
          );
        },
        icon:Icon(Icons.archive_outlined),


      ),
    ],
  ),
);

Widget buildArticleComponent (article)=>Padding (
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          image: DecorationImage(
            image: NetworkImage('${article['urlToImage']}'),
            fit:BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 20.0,),
      Container(
        height: 120.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${article['title']}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,

              ),
              maxLines: 2,
            ),
            Text(
              '${article['publishedAt']}',
              style: TextStyle(
                fontSize: 15.0,
                color: CupertinoColors.systemGrey2,

              ),
            ),

          ],
        ),
      ),
    ],
  ),
);