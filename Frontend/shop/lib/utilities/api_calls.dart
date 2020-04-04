import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class ApiCalls {
  static const serverIp = 'http://3.20.217.170:8080';
  static Dio dio;

  static dynamic getRequest(
      List<String> pathList, Map<String, dynamic> parameters) async {
    Response response;

    String url = serverIp;
    for (var path in pathList) {
      url = url + '/' + path;
    }
    url = url + '/';

    if (dio == null) dio = Dio();

    try {
      response = await dio.get(url, queryParameters: parameters);
      if (response.statusCode == 200)
        return response.data;
      else
        return null;
    } on DioError catch (e) {
      print("Connection error:" + e.toString());
      return null;
    }
  }

  static dynamic postRequest(
      List<String> pathList, Map<String, dynamic> parameters) async {
    Response response;

    String url = serverIp;
    for (var path in pathList) {
      url = url + '/' + path;
    }
    url = url + '/';

    if (dio == null) dio = Dio();

    try {
      response = await dio.post(url, data: FormData.fromMap(parameters));
      if (response.statusCode == 200)
        return response.data;
      else
        return null;
    } on DioError catch (e) {
      print("Connection Error:" + e.toString());
      return null;
    }
  }
}
