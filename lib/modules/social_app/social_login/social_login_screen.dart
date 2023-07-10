import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/social_app/social_layout_screen.dart';
import 'package:nour/modules/social_app/social_login/social_cubit/social_cubit.dart';
import 'package:nour/modules/social_app/social_login/social_cubit/social_states.dart';
import 'package:nour/modules/social_app/social_register_screen/social_register_screen.dart';
import 'package:nour/network/local/cache_helper.dart';
import 'package:toast/toast.dart';
import '../../../sharing/sharing.component/components.dart';
import '../../shop_app/shop_login_screen/shop_cubit/shop_cubit.dart';
import '../../todo_app/shop_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
var formKey = GlobalKey<FormState>();
var emailController =TextEditingController();
var passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
      listener: (context, state) {
 if(state is SocialErrorLoginState){
   ToastContext toastContext = ToastContext();
   toastContext.init(context);
   Toast.show(state.error!,backgroundColor: Colors.red,duration: Toast.lengthLong );

 }
 if(state is SocialSuccessLoginState){
   CacheHelper.saveData(key: 'uId',
       value:state.uId
   ).then((value) {
navigateAndFinish(context, SocialLayout()
);
   });
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
                          suffex: SocialLoginCubit.get(context).suffix,
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
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        //  isPassword:SocialLoginCubit.get(context).isPass,
                        //   suffexPass: (){
                        //     SocialLoginCubit.get(context).changePasswordVisibility();
                        //   },
                          prefex: Icons.lock,
                        ),
                        SizedBox(
                          height: 30.0 ,
                        ),
                        ConditionalBuilder(
                          condition: state is !SocialLoadingLoginState,
                          builder: (context) => defaultButton(function: (){
                            if(formKey.currentState!.validate()){
                              SocialLoginCubit.get(context).userLogin(
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
                                navigateTo(context, SocialRegisterScreen());
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
