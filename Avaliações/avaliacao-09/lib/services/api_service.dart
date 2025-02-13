import 'package:avaliacao_09/constants/api_constants.dart';
import 'package:avaliacao_09/models/isbn_model.dart';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiService {
  Future<IsbnModel?> getAddress({required String isbn}) async {
    try {
      var response = await Dio().get(ApiConstants.urlBase(isbn));

      if (response.statusCode == 200) {
        return IsbnModel.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}