class SocialUsersModel{

  String? name ;
  String? email ;
  String? uId ;
  String? phone ;
  SocialUsersModel({
    this.name,
    this.email,
    this.uId,
    this.phone,

  });
  SocialUsersModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uId=json['uId'];
    phone=json['phone'];

  }
  Map<String,dynamic> toMap (){
    return{
      'name':name,
      'email':email,
      'uId':uId,
      'phone':phone,

    };
  }

}