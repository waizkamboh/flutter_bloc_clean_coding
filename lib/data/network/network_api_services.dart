
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exception/app_exceptions.dart';
import 'base_api_services.dart';


class NetworkApiServices extends BaseApiServices{

  @override
  Future<dynamic> getApi(String url, {Map<String, String>? headers} ) async{
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url),
          headers: headers

      );
      responseJson = returnResponse(response);



    }on SocketException{
      throw InternetException();

    }on RequestTimeOut{
      throw RequestTimeOut();
    }
    return responseJson;



  }

  @override
  Future<dynamic> getByIdApi(String url, {Map<String, String>? headers} ) async{
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url),
          headers: headers

      );
      responseJson = returnResponse(response);



    }on SocketException{
      throw InternetException();

    }on RequestTimeOut{
      throw RequestTimeOut();
    }
    return responseJson;



  }

  @override
  Future<dynamic> postApi(var data, String url,{Map<String, String>? headers} )async{

    if(kDebugMode){
      print(url);
      print(data);
    }
    dynamic responseJson;
    print('responseJson$responseJson');
    try{
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(data),
          headers: headers


      );
      responseJson = returnResponse(response);

    }on SocketException{
      throw InternetException('');

    }on RequestTimeOut{
      throw RequestTimeOut();
    }

    return responseJson;
  }

  @override
  Future<dynamic> postMultipartApi(
      String url, {
        required Map<String, String> fields,
        required List<File> files,
        Map<String, String>? headers,
      }) async {
    if(kDebugMode){
      print(url);
      print(fields);
      print(files);
    }
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // headers
      if (headers != null) {
        request.headers.addAll(headers);
      }

      // fields (text data)
      request.fields.addAll(fields);

      // files (documents[])
      for (var file in files) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'documents', // backend expects array
            file.path,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return returnResponse(response);
    } on SocketException {
      throw InternetException();
    }
  }


  @override
  Future<dynamic> deleteApi(String url, {Map<String, String>? headers}) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return responseJson;
  }

  @override
  Future<dynamic> updateApi(var data, String url, {Map<String, String>? headers}) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url),
          body: jsonEncode(data),
          headers: headers
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }

    return responseJson;
  }



  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print(response.body);
      print(response.statusCode);
    }

    switch (response.statusCode) {

      case 200:
      case 201:
      case 400:
      case 401:
      case 403:
      case 404:
      case 422:
        return jsonDecode(response.body);

      case 500:
        throw ServerException('Server error');

      default:
        if (kDebugMode) {
          print('Unhandled Status Code: ${response.statusCode}');
          print(response.body);
        }
        throw FetchDataException(
          'Something went wrong. Please try again.',
        );

    }
  }


}