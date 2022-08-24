import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lavie/shared/cache_helper.dart';

import '../api_models/auth/User.dart';

class AppConstants {
  static User? user;
  static String? accessToken;
  static const apiBaseUrl = 'https://lavie.orangedigitalcenteregypt.com';
  static final dio = Dio();

  static init() {
    accessToken = CacheHelper.getString(SharedKeys.apiToken);
    if (kDebugMode) {
      print('accessToken: $accessToken');
      print('cache: ${CacheHelper.getString(SharedKeys.apiToken)}');
    }
  }
}
