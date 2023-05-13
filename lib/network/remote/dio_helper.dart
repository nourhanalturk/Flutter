import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper{

  static Dio? dio ;

  static init (){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
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
    required String url,
    required Map<String,dynamic> query
  })async
  {
    init();
   return await dio?.get(url , queryParameters:query );
  }


}