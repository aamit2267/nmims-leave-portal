import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/faculty_model.dart';
import 'package:nmims_leave_portal/store/app_store.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/widgets/leave_card.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/widgets/leave_card_hod.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/widgets/leave_card_pc.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/home_screen.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/widgets/end_drawer.dart';
import 'package:nmims_leave_portal/view/widgets/app_bar.dart';

class PendingLeavesPage extends StatefulWidget {
  final FacultyModel currentFaculty;
  const PendingLeavesPage({super.key, required this.currentFaculty});

  @override
  State<PendingLeavesPage> createState() => _PendingLeavesPageState();
}

class _PendingLeavesPageState extends State<PendingLeavesPage> {
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
        endDrawerEnableOpenDragGesture: false,
        endDrawer: endDrawerFaculty(
          scaffoldKey: scaffoldKey,
          role: 'faculty',
          currentFaculty: widget.currentFaculty,
        ),
        body: SafeArea(
          child: Column(
            children: [
              customAppBar(scaffoldKey),
              Text(
                'PENDING LEAVES',
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
                            future: appStore.getPendingLeaves(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: appStore.leaves.length,
                                itemBuilder: (context, index) {
                                  if (appStore.leaves[index].status ==
                                      'PENDING') {
                                    return leaveCard(
                                      leave: appStore.leaves[index],
                                      appStore: appStore,
                                      currentFaculty: widget.currentFaculty,
                                    );
                                  } else if (appStore.leaves[index].status ==
                                      'FORWARDED TO PROGRAM CHAIR') {
                                    return leaveCardPC(
                                      leave: appStore.leaves[index],
                                      appStore: appStore,
                                      currentFaculty: widget.currentFaculty,
                                    );
                                  } else if (appStore.leaves[index].status ==
                                      'FORWARDED TO HOD') {
                                    return leaveCardHOD(
                                      leave: appStore.leaves[index],
                                      appStore: appStore,
                                      currentFaculty: widget.currentFaculty,
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
