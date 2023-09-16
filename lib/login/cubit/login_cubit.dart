import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:taxi_attendence_app/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginInitialState());

  final AuthenticationRepository _authenticationRepository;
  String phoneNumberval = "";

  Future<void> logInWithPhoneNumber(String phoneNumber) async {
    emit(LoginLoadingState());
    try {
      phoneNumberval = phoneNumber;
      await _authenticationRepository.sendOtp(phoneNumber: phoneNumber);
      emit(LoginCodeSentState());
    } on PhoneLoginFailure catch (e) {
      emit(LoginErrorState(e.message, ErrorType.phone));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(LoginLoadingState());
    try {
      await _authenticationRepository.verifyOTP(otp: otp);
      await _authenticationRepository.signIn();
      emit(LoginLoggedInState());
    } on PhoneLoginFailure catch (e) {
      emit(LoginErrorState(e.message, ErrorType.otp));
    }
  }
}
