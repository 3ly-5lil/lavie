import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../shared/cache_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitState()) {
    CacheHelper.init();
    start();
  }

  start() async {
    return Timer(const Duration(milliseconds: 500), () {
      emit(SplashStopState());
    });
  }
}
