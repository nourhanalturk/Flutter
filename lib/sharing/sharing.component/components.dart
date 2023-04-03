import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    validate(v);
    },
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(
        prefex,
      ),
      suffixIcon: suffex != null ?IconButton(
        onPressed: (){
          suffexPass!();
        },
        icon: Icon(
         suffex,
        ),
      ) :null,
      border: OutlineInputBorder(),
    ),
  );
}