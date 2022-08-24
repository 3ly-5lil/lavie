import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie/shared/app_constants.dart';
import 'package:lavie/shared/cache_helper.dart';
import 'package:meta/meta.dart';

import '../../../api_models/auth/AuthResponse.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState()) {
    CacheHelper.init();
  }

  late AuthResponse response;

  signUp({
    required buildContext,
    required firstName,
    required lastName,
    required email,
    required password,
  }) async {
    emit(SigningUpStartedState());

    await AppConstants.dio.post(
      '${AppConstants.apiBaseUrl}/api/v1/auth/signup',
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      },
    ).then((value) {
      printResponse(value);

      response = AuthResponse.fromJson(value.data);

      setToCache();
      emit(SigningUpFinishedState());
    }).catchError((error) {
      if (error is DioError) {
        emit(SigningUpErrorState());
        if (error.message == 'Http status error [409]') {
          ScaffoldMessenger.of(buildContext).showSnackBar(
              const SnackBar(content: Text('account already registered')));
        } else {
          response = AuthResponse.fromJson(error.response?.data);

          printError(error);

          ScaffoldMessenger.of(buildContext).showSnackBar(
              SnackBar(content: Text(error.response?.data['message'][0])));
        }
      }
    });
  }

  signIn({
    required buildContext,
    required email,
    required password,
  }) async {
    emit(LoggingInStartedState());

    await AppConstants.dio.post(
      '${AppConstants.apiBaseUrl}/api/v1/auth/signin',
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      printResponse(value);

      response = AuthResponse.fromJson(value.data);

      setToCache();

      emit(LoggingInFinishedState());
    }).catchError((error) {
      if (error is DioError) {
        response = AuthResponse.fromJson(error.response?.data);

        printError(error);

        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(
            content: Text(response.message!),
          ),
        );
        emit(LoggingInErrorState());
      }
    });
  }

  void printError(DioError error) {
    debugPrint('error Processed!');
    debugPrint('status code: ${error.response?.statusCode.toString()}');
    debugPrint('status message: ${error.response?.statusMessage.toString()}');

    debugPrint('response type: ${response.type}');
    debugPrint('response message: ${response.message}');

    debugPrint('----------------------');
  }

  void setToCache() {
    AppConstants.accessToken = response.data!.accessToken;

    CacheHelper.setString(SharedKeys.apiToken, AppConstants.accessToken!);
    if (kDebugMode) {
      print('shared pref access${CacheHelper.getString(SharedKeys.apiToken)}');
    }
    AppConstants.dio.options.headers['Authorization'] =
        'Bearer ${AppConstants.accessToken}';
  }

  void printResponse(Response<dynamic> value) {
    debugPrint('request Processed!');

    debugPrint('status code: ${value.statusCode.toString()}');
    debugPrint('status message: ${value.statusMessage.toString()}');
    debugPrint('response type: ${value.data['type'].toString()}');
    debugPrint('response message: ${value.data['message'].toString()}');

    debugPrint('----------------------');
  }
}
