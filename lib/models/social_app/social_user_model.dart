class SocialUsersModel{

  String? name ;
  String? email ;
  String? uId ;
  String? phone ;
  bool? isEmailVerified;
  SocialUsersModel({
    this.name,
    this.email,
    this.uId,
    this.phone,
    this.isEmailVerified
  });
  SocialUsersModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uId=json['uId'];
    phone=json['phone'];
    isEmailVerified=json['isEmailVerified'];

  }
  Map<String,dynamic> toMap (){
    return{
      'name':name,
      'email':email,
      'uId':uId,
      'phone':phone,
      'isEmailVerified':isEmailVerified,
    };
  }

}