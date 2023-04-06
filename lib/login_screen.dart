import 'package:flutter/material.dart';
import 'package:nour/sharing/sharing.component/components.dart';
//....
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool ispass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate:(String? value){
                        if(value!.isEmpty){
                          return'email address must not be empty';
                        }
                       return null ;
                      },
                      text: 'Email adress ',
                      prefex: Icons.email,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value){
                        if(value == null ||value.isEmpty){
                          return 'password??';
                        }
                        return null ;
                      },
                      text: 'password',
                      prefex:Icons.lock,
                    suffex: ispass ?Icons.visibility : Icons.visibility_off,
                    isPassword: ispass,
                    suffexPass: (){
                        setState(() {
                          ispass = !ispass;
                        });

                    }

                  ),
                  // TextFormField(
                  //   controller: passwordController,
                  //   keyboardType: TextInputType.visiblePassword,
                  //   obscureText: true,
                  //   onFieldSubmitted: (String value) {
                  //     print(value);
                  //   },
                  //   onChanged: (String value) {
                  //     print(value);
                  //   },
                  //   validator: (value) {
                  //     if(value!.isEmpty){
                  //       return 'password must not be  empty';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //     prefixIcon: Icon(
                  //       Icons.lock,
                  //     ),
                  //     suffixIcon: Icon(
                  //       Icons.remove_red_eye,
                  //     ),
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                 defaultButton(
                     function:(){
                       if(formkey.currentState!.validate()){

                       print(emailController.text);
                       print(passwordController.text);
                       }
                     },
                     text: 'login'
                 ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
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
  }
}