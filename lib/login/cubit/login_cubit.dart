import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:taxi_attendence_app/login/cubit/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super( LoginInitialState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithPhoneNumber(String phoneNumber) async {
    try {
      emit( LoginLoadingState());
      await _authenticationRepository.sendOtp(phoneNumber: phoneNumber);
      emit( LoginCodeSentState());
    } on Exception catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  verif
}
