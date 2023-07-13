
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
         //emit(SocialRegisterSuccessState());
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
    SocialUsersModel model = SocialUsersModel(
        email: email,
        name: name,
        phone: phone,
        image: 'https://img.freepik.com/free-photo/cheerful-curly-haired-woman-crosses-arms-chest-points-left-right-gives-two-variants-says-both-are-good-advertises-products_273609-39142.jpg?w=996&t=st=1689267849~exp=1689268449~hmac=fc815a574fd2ee46d31ce9a049adcd5922dd30541ee0512f597720d602548f8a',
        bio: 'Write your bio ...',
        cover: 'https://img.freepik.com/free-photo/cheerful-curly-haired-woman-crosses-arms-chest-points-left-right-gives-two-variants-says-both-are-good-advertises-products_273609-39142.jpg?w=996&t=st=1689267849~exp=1689268449~hmac=fc815a574fd2ee46d31ce9a049adcd5922dd30541ee0512f597720d602548f8a',
        uId: uId);

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