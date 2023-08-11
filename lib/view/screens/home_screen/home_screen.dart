import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nmims_leave_portal/store/app_store.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/home.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/widgets/end_drawer.dart';
import 'package:nmims_leave_portal/view/screens/student_section/home.dart';
import 'package:nmims_leave_portal/view/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formatter = NumberFormat('00');
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final appStore = AppStore();

  @override
  void initState() {
    appStore.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (scaffoldKey.currentState!.isEndDrawerOpen) {
          scaffoldKey.currentState?.closeEndDrawer();
          return false;
        } else {
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        backgroundColor: ColorConstants.white,
        endDrawer: FutureBuilder(
          future: appStore.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (appStore.role == 'student') {
                return endDrawerStudent(
                  scaffoldKey,
                  appStore.role,
                  appStore.currentStudent,
                  context,
                );
              } else {
                return endDrawerFaculty(
                  scaffoldKey,
                  appStore.role,
                  appStore.currentFaculty,
                  context,
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              customAppBar(scaffoldKey),
              Center(
                child: Text(
                  '${formatter.format(DateTime.now().day)}.${formatter.format(DateTime.now().month)}.${DateTime.now().year}',
                  style: GoogleFonts.inter(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.black,
                  ),
                ),
              ),
              Center(
                child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      '${formatter.format(DateTime.now().hour > 12 ? DateTime.now().hour - 12 : DateTime.now().hour)}:${formatter.format(DateTime.now().minute)} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder(
                future: appStore.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (appStore.currentUser.role == 'student') {
                      return studentHome(context, appStore.currentStudent);
                    } else {
                      return facultyHome(context, appStore.currentFaculty);
                    }
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
