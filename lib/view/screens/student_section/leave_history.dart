import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/student_model.dart';
import 'package:nmims_leave_portal/store/app_store.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/home_screen.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/widgets/end_drawer.dart';
import 'package:nmims_leave_portal/view/screens/student_section/widgets/leave_card.dart';
import 'package:nmims_leave_portal/view/widgets/app_bar.dart';

class LeaveHistoryScreen extends StatefulWidget {
  final StudentModel currentStudent;
  const LeaveHistoryScreen({super.key, required this.currentStudent});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final appStore = AppStore();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const HomeScreen(),
            transitionDuration: const Duration(seconds: 0),
          ),
        );
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorConstants.white,
        endDrawer: endDrawerStudent(
          scaffoldKey,
          'student',
          widget.currentStudent,
          context,
        ),
        endDrawerEnableOpenDragGesture: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customAppBar(scaffoldKey),
              Text(
                'LEAVE HISTORY',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.black,
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: 1,
                        (BuildContext context, int index) {
                          return FutureBuilder(
                            future: appStore.getLeaveHistory(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: appStore.leaves.length,
                                itemBuilder: (context, index) {
                                  if (appStore.leaves[index].status ==
                                          'APPROVED' ||
                                      appStore.leaves[index].status ==
                                          'REJECTED') {
                                    return leaveCard(
                                      leave: appStore.leaves[index],
                                    );
                                  } else if (appStore.leaves[index].status ==
                                          'PENDING' ||
                                      appStore.leaves[index].status ==
                                          'FORWARDED TO PROGRAM CHAIR' ||
                                      appStore.leaves[index].status ==
                                          'FORWARDED TO HOD') {
                                    appStore.leaves[index].status = 'PENDING';
                                    return leaveCard(
                                      leave: appStore.leaves[index],
                                    );
                                  }
                                  return const SizedBox();
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
