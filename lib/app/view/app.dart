import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:taxi_attendence_app/app/bloc/app_bloc.dart';
import 'package:taxi_attendence_app/components/loading/loading_widget.dart';
import 'package:taxi_attendence_app/home/view/home.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => AppBloc(
              authenticationRepository: widget._authenticationRepository,
            ),
          ),
        ],
        child: Portal(
          child: MaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: const AppView(),
          ),
        ),
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
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        switch (state.status) {
          case AppStatus.authenticated:
            return const HomePage();
          case AppStatus.unauthenticated:
            return BlocProvider(
              create: (_) => LoginCubit(
                context.read<AuthenticationRepository>(),
              ),
              child: const PhoneNumberPage(),
            );
          case AppStatus.loading:
            return const Loading();
        }
      },
    );
  }
}
