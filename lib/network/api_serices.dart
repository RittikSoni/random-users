import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:by_rittik/models/user_details_model.dart';
import 'package:by_rittik/models/users_model.dart';
import 'package:by_rittik/network/api_error_handler.dart';

class APiServices {
  static final APiServices _api = APiServices._internal();

  factory APiServices() {
    return _api;
  }

  APiServices._internal();

  static const baseUrl = "https://reqres.in/api";

  Future<UsersModel> getUsers(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users?page=$page'));

      if (response.statusCode == 200) {
        return UsersModel.fromJson(jsonDecode(response.body));
      } else {
        throw ApiErrorHandler(
            statusCode: response.statusCode, message: response.body.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<UserDetailModel> getUserDetails(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

      if (response.statusCode == 200) {
        return UserDetailModel.fromJson(jsonDecode(response.body));
      } else {
        throw ApiErrorHandler(
            statusCode: response.statusCode, message: response.body.toString());
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
