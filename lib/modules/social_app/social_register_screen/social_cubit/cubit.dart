
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/models/social_app/social_user_model.dart';
import 'package:nour/modules/social_app/social_register_screen/social_cubit/state.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
  {
    required name,
    required email,
    required password,
    required phone
}){
       emit(SocialRegisterLoadingState());
       FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: email,
           password: password,
       ).then((value) {
         print(value.user!.email);
         print(value.user!.uid);
         userCreate(
             uId: value.user!.uid,
           phone: phone,
           name: name,
           email: email
         );
         emit(SocialRegisterSuccessState());
       }
       ).catchError((error){
         emit(SocialRegisterErrorState(error));
       }
       );


  }
  void userCreate(
      {
        required name,
        required email,
        required phone,
        required uId
      }){
    SocialUsersModel model = SocialUsersModel(email: email,name: name,phone: phone,uId: uId);

           FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
             emit(SocialCreateUserSuccessState());
           }).catchError((error){
             if (error is FirebaseAuthException) {
               final errorMessage = error.message ?? 'An unknown error occurred';
               emit(SocialCreateUserErrorState(errorMessage));
             } else {
               final errorMessage = error.toString();
               emit(SocialCreateUserErrorState(errorMessage));
             }

           });
  }

}