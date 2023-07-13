class SocialUsersModel{

  String? name ;
  String? email ;
  String? uId ;
  String? image ;
  String? cover ;
  String? bio ;
  String? phone ;
  bool? isEmailVerified;
  SocialUsersModel({
    this.name,
    this.email,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.phone,
    this.isEmailVerified
  });
  SocialUsersModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uId=json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    phone=json['phone'];
    isEmailVerified=json['isEmailVerified'];

  }
  Map<String,dynamic> toMap (){
    return{
      'name':name,
      'email':email,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'phone':phone,
      'isEmailVerified':isEmailVerified,
    };
  }

}