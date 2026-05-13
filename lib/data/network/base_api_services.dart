import 'dart:io';

abstract class BaseApiServices {

  Future<dynamic> getApi(String url, {Map<String, String>? headers});
  Future<dynamic> postApi(dynamic data, String url, {Map<String, String>? headers});
  Future<dynamic> postMultipartApi(String url, {required Map<String, String> fields, required List<File> files, Map<String, String>? headers,});
  Future<dynamic> deleteApi(String url, {Map<String, String>? headers});
  Future<dynamic> getByIdApi(String url, {Map<String, String>? headers});
  Future<dynamic> updateApi(dynamic data, String url, {Map<String, String>? headers});

}