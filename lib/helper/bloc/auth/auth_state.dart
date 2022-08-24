part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class SigningUpStartedState extends AuthState {}

class SigningUpErrorState extends AuthState {}

class SigningUpFinishedState extends AuthState {}

class LoggingInStartedState extends AuthState {}

class LoggingInErrorState extends AuthState {}

class LoggingInFinishedState extends AuthState {}
