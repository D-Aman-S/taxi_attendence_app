import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_attendence_app/app/app.dart';
import 'package:taxi_attendence_app/app/bloc/app_bloc.dart';
import 'package:taxi_attendence_app/components/custom_app_bar.dart';
import 'package:taxi_attendence_app/components/custom_button.dart';
import 'package:taxi_attendence_app/components/custom_spaces.dart';
import 'package:taxi_attendence_app/components/loading/loading_screen.dart';
import 'package:taxi_attendence_app/home/components/bottom_cards.dart';
import 'package:taxi_attendence_app/home/components/earnings_container.dart';
import 'package:taxi_attendence_app/home/components/popup.dart';
import 'package:taxi_attendence_app/home/components/shift_tracker.dart';
import 'package:taxi_attendence_app/utilities/color_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: CustomAppBar(
                appBarTitle: '',
                endButton: ModalEntry(
                  visible: _showMenu,
                  onClose: () => setState(() => _showMenu = false),
                  childAnchor: Alignment.topRight,
                  menuAnchor: Alignment.topLeft,
                  menu: Menu(
                    children: [
                      const Spacer(),
                      PopupMenuItem<void>(
                        height: 50,
                        child: Text(
                          'View Profile',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: fontColor),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xffD1E0E3),
                      ),
                      PopupMenuItem<void>(
                        height: 50,
                        child: Text(
                          'Change Photo',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: fontColor),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xffD1E0E3),
                      ),
                      PopupMenuItem<void>(
                        onTap: () async {
                          setState(() {
                            _showMenu = false;
                          });
                          BlocProvider.of<AppBloc>(context)
                              .add(const AppLogoutRequested());
                          // LoadingScreen().show(context: context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => App(
                          //               authenticationRepository: context
                          //                   .read<AuthenticationRepository>(),
                          //             )));
                        },
                        height: 50,
                        child: Text(
                          'Logout',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: fontColor),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 22, top: 21),
                    child: InkWell(
                      onTap: () => setState(() => _showMenu = true),
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset("assets/profile.png"),
                      ),
                    ),
                  ),
                ))),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                HeightSpace(34),
                ShiftTracker(),
                HeightSpace(30),
                EarningsContainer(),
                BottomCards()
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Semantics(
            label: "Submit",
            child: SizedBox(
                height: getHeight(height),
                child: Column(
                  children: [
                    CustomButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 502,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: const BoxDecoration(
                                  color: Color(0xff0E2227),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const HeightSpace(28),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 40,
                                            )),
                                      ],
                                    ),
                                    const HeightSpace(40),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "How to mark attendance",
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const HeightSpace(41),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 172,
                                          child: Image.asset(
                                              "assets/clickpic.png"),
                                        ),
                                        const HeightSpace(21),
                                        SizedBox(
                                          height: 30,
                                          width: 205,
                                          child: Image.asset("assets/loc.png"),
                                        ),
                                        const HeightSpace(21),
                                        SizedBox(
                                          height: 30,
                                          width: 328,
                                          child: Image.asset(
                                              "assets/approvedloc.png"),
                                        ),
                                        const HeightSpace(21),
                                      ],
                                    ),
                                    const HeightSpace(72),
                                    CustomButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 550,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const HeightSpace(28),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.black,
                                                              size: 40,
                                                            )),
                                                      ],
                                                    ),
                                                    const HeightSpace(70),
                                                    SizedBox(
                                                      width: 150,
                                                      height: 190,
                                                      child: Image.asset(
                                                          'assets/present.png'),
                                                    ),
                                                    const HeightSpace(10),
                                                    Text(
                                                      "You are Present!",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 24,
                                                          color: Colors.black),
                                                    ),
                                                    const HeightSpace(21),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      displayText: "Proceed",
                                      borderRadius: 20,
                                      height: 60,
                                      color1: themeGradientColor1,
                                      color2: themeGradientColor2,
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      displayText: "Mark Attendence",
                      textSize: 20,
                      height: 60,
                      borderRadius: 15,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          height: 22,
                          width: 16,
                          child: Image.asset("assets/attendance.png"),
                        ),
                      ),
                      color1: fontColor,
                      color2: fontColor,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  getHeight(double height) {
    if (height < 825) {
      return 70;
    } else
      return 120;
  }
}
