abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginCodeSentState extends LoginState {}

class LoginCodeVerifiedState extends LoginState {}

class LoginLoggedInState extends LoginState {}

class LoginLoggedOutState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
