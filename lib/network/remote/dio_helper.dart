import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper{

  static Dio? dio ;

  static init (){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
    dio?.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }
  static Future<Response?> getData({
    required String url, //end point
    Map<String,dynamic>? query,
    String lang ='en',
    String? token ,
  })async
  {
    dio?.options.headers ={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };

    init();
   return await dio?.get(url , queryParameters:query );
  }

  static Future<Response> postData (
  {
    required String  url,
    Map<String,dynamic>? query,
    required Map<String ,dynamic> data,
    String lang ='ar',
    String? token ,
  }
)async
{
  dio?.options.headers ={
    'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token,
  };
    return await dio!.post(
        url,
      queryParameters: query,
      data: data

    );
}


}