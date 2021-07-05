import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/services/http.service.dart';

class AuthRequest extends HttpService {
  //
  Future<ApiResponse> loginRequest({
    @required String email,
    @required String password,
  }) async {
    final apiResult = await post(
      Api.login,
      {
        "email": email,
        "password": password,
        "role": "manager",
      },
    );

    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> resetPasswordRequest({
    @required String phone,
    @required String password,
    @required String firebaseToken,
  }) async {
    final apiResult = await post(
      Api.forgotPassword,
      {
        "phone": phone,
        "password": password,
        "firebase_id_token": firebaseToken,
      },
    );

    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> logoutRequest() async {
    final apiResult = await get(Api.logout);
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> updateProfile({
    File photo,
    String name,
    String email,
    String phone,
  }) async {
    final apiResult = await postWithFiles(
      Api.updateProfile,
      {
        "_method": "PUT",
        "name": name,
        "email": email,
        "phone": phone,
        "photo": photo != null
            ? await MultipartFile.fromFile(
                photo.path,
              )
            : null,
      },
    );
    return ApiResponse.fromResponse(apiResult);
  }

  Future<ApiResponse> updatePassword({
    String password,
    String new_password,
    String new_password_confirmation,
  }) async {
    final apiResult = await post(
      Api.updatePassword,
      {
        "_method": "PUT",
        "password": password,
        "new_password": new_password,
        "new_password_confirmation": new_password_confirmation,
      },
    );
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> verifyPhoneAccount(String phone) async {
    final apiResult = await get(
      Api.verifyPhoneAccount,
      queryParameters: {
        "phone": phone,
      },
    );

    return ApiResponse.fromResponse(apiResult);
  }
}
