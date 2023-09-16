import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginCodeSentState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginCodeVerifiedState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoggedInState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoggedOutState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  final String error;
  final ErrorType errorType;
  LoginErrorState(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}

enum ErrorType { phone, otp }
