import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavie/shared/cache_helper.dart';

import '../../../helper/bloc/splash/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (_, state) {
          if (state is SplashStopState) {
            if (CacheHelper.getString(SharedKeys.apiToken) == '') {
              Navigator.pushReplacementNamed(_, '/log');
            } else if (CacheHelper.getString(SharedKeys.gotFreeSeed) == '') {
              Navigator.pushReplacementNamed(_, '/claimSeed');
            } else {
              Navigator.pushReplacementNamed(_, '/home');
            }
          }
        },
        child: SafeArea(
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/images/logo.svg'),
          ),
        ),
      ),
    );
  }
}
