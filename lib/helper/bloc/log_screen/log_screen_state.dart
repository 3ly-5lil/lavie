part of 'log_screen_cubit.dart';

class LogScreenState extends Equatable {
  bool inLogScreen;

  LogScreenState({this.inLogScreen = true});

  @override
  List<Object> get props => [inLogScreen];
}
