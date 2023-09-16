import 'package:flutter/widgets.dart';
import 'package:taxi_attendence_app/app/app.dart';
import 'package:taxi_attendence_app/app/bloc/app_bloc.dart';
import 'package:taxi_attendence_app/components/loading/loading_widget.dart';
import 'package:taxi_attendence_app/home/view/home.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginWrapper.page()];
    case AppStatus.loading:
    default:
      return [Loading.page()];
  }
}
