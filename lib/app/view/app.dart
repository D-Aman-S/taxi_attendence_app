import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:taxi_attendence_app/app/bloc/app_bloc.dart';
import 'package:taxi_attendence_app/app/routes/routes.dart';
import 'package:taxi_attendence_app/components/loading/loading_widget.dart';
import 'package:taxi_attendence_app/home/view/home.dart';
import 'package:taxi_attendence_app/login/cubit/login_state.dart';
import 'package:taxi_attendence_app/login/login.dart';
import 'package:taxi_attendence_app/theme.dart';

class App extends StatefulWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget._authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: widget._authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp(
        theme: theme,
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
  }
}

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});
  static Page<void> page() => const MaterialPage<void>(child: LoginWrapper());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: Builder(builder: (context) {
        return BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginCodeSentState) {
              return const OtpPage();
            } else if (state is LoginLoggedInState) {
              return const Loading();
            } else if (state is LoginErrorState) {
              if (state.errorType == ErrorType.phone) {
                return const PhoneNumberPage();
              } else {
                return const OtpPage();
              }
            } else {
              return PhoneNumberPage(
                key: UniqueKey(),
              );
            }
          },
        );
      }),
    );
  }
}
