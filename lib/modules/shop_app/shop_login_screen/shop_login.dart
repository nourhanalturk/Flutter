import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nour/modules/shop_app/shop_login_screen/shop_cubit/shop_cubit.dart';
import 'package:nour/modules/shop_app/shop_login_screen/shop_cubit/shop_states.dart';
import 'package:nour/modules/todo_app/shop_register_screen.dart';
import 'package:nour/sharing/sharing.component/components.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =TextEditingController();
    var passwordController =TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if (state is ShopSuccessLoginState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.data?.token);
              Fluttertoast.showToast(
                  msg: state.loginModel.message ?? " ",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            } else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message ?? " ",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              print(state.loginModel.message);

            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers ',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),

                        ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'email must not be empty ';
                              }
                              return null ;
                            },
                            text: 'Email Address',
                            prefex: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15.0 ,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffex: ShopLoginCubit.get(context).suffix,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Password is too short';
                            }
                            return null ;
                          },
                         text: 'Password',
                         onSubmit: (value)
                         {
                           if(formKey.currentState!.validate()){
                             ShopLoginCubit.get(context).userLogin(
                                 email: emailController.text,
                                 password: passwordController.text);
                           }
                         },
                          isPassword:ShopLoginCubit.get(context).isPass,
                          suffexPass: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                         prefex: Icons.lock,
                        ),
                        SizedBox(
                          height: 30.0 ,
                        ),
                        ConditionalBuilder(
                          condition: state is !ShopLoadingLoginState,
                          builder: (context) => defaultButton(function: (){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }

                          }, text: 'Login',),

                          fallback: (context) => Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(
                          height: 15.0 ,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Dont have an account ?'
                            ),
                            defaultTextButton(
                              text: 'Register now ',
                              function: (){
                                navigateTo(context, ShopRegisterScreen);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
