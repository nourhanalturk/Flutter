class PostModel{

  String? name ;
  String? uId ;
  String? image ;
  String? text ;
  String? dateTime ;
  String? postImage ;


  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
  });
  PostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    text=json['text'];
    uId=json['uId'];
    image=json['image'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
  }
  Map<String,dynamic> toMap (){
    return{
      'name':name,
      'text':text,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'postImage':postImage,

    };
  }

}