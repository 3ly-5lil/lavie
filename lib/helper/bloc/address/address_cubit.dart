import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lavie/api_models/address/ClaimFreeSeedResponse.dart';
import 'package:lavie/shared/app_constants.dart';

import '../../../shared/cache_helper.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final _dio = Dio();
  late ClaimFreeSeedResponse respond;

  sendRequest(String address) async {
    await _dio.post('${AppConstants.apiBaseUrl}/api/v1/user/me/claimFreeSeeds',
        data: {
          "address": address,
        }).then((value) {
      respond = ClaimFreeSeedResponse.fromJson(value.data);

      emit(AddressSentSuccessful(respond));
      CacheHelper.setString(SharedKeys.gotFreeSeed, 'done');
      printResponse();
    }).catchError((error) {
      if (error is DioError) {
        respond = ClaimFreeSeedResponse.fromJson(error.response!.data);
        emit(AddressSentError(respond));
        printResponse();
      }
    });
  }

  void printResponse() {
    debugPrint('res type: ${respond.type}');
    debugPrint('res message: ${respond.message}');
  }
}
