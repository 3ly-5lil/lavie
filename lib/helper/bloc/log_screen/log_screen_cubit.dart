import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'log_screen_state.dart';

class LogScreenCubit extends Cubit<LogScreenState> {
  LogScreenCubit() : super(LogScreenState());

  switchScreen() {
    emit(LogScreenState(inLogScreen: !state.inLogScreen));
  }
}
