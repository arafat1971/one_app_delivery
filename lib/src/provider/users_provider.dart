import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:one_app_delivery/src/api/enviroment.dart';
import 'package:one_app_delivery/src/models/response_api.dart';
import 'package:one_app_delivery/src/models/user.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class UsersProvider {
  final String _url = Enviroment.API_DELIVERY;
  final String _api = 'api/user';

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
    return null;
  }

  Future<Stream?> createWithImage(User user, File image) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);

      // ignore: unnecessary_null_comparison
      if (image != null) {
        request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path),
        ));
      }
      request.fields['user'] = json.encode(user);
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      // ignore: avoid_print
      print('Error $e');
      return null;
    }
  }

  Future<ResponseApi?> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      // ignore: avoid_print
      print('Exception data $e');
      return null;
    }
  }

  Future<ResponseApi?> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      // ignore: avoid_print
      print('Exception data $e');
      return null;
    }
  }
}
