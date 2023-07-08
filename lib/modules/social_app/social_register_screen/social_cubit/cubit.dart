
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

         emit(SocialRegisterSuccessState());
       }
       ).catchError((error){
         emit(SocialRegisterErrorState(error));
       }
       );


  }

}