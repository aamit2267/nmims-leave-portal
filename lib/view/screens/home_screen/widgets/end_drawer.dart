// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/faculty_model.dart';
import 'package:nmims_leave_portal/models/student_model.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/auth_screen/auth_screen.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/pending_leaves.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/home_screen.dart';
import 'package:nmims_leave_portal/view/screens/student_section/apply_leave.dart';
import 'package:nmims_leave_portal/view/screens/student_section/leave_history.dart';
import 'package:nmims_leave_portal/view/screens/student_section/leave_status.dart';

class endDrawerStudent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? role;
  final StudentModel currentStudent;
  const endDrawerStudent(
      {super.key,
      required this.scaffoldKey,
      this.role,
      required this.currentStudent});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: ColorConstants.icongrey,
                    size: 30,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState?.closeEndDrawer();
                  },
                ),
              ],
            ),
            (role == 'student')
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentStudent.name!,
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.black,
                          ),
                        ),
                        Text(
                          currentStudent.sapId!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.disabledText,
                          ),
                        ),
                        Text(
                          currentStudent.rollNo!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.disabledText,
                          ),
                        ),
                        Text(
                          '${currentStudent.program} ${currentStudent.branch}',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.disabledText,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const HomeScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/home.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'HOME',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        ApplyLeaveScreen(
                      currentStudent: currentStudent,
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/timer.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'APPLY LEAVE',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.golden,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LeaveStatusScreen(
                      currentStudent: currentStudent,
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/rejected.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'LEAVE STATUS',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LeaveHistoryScreen(
                      currentStudent: currentStudent,
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/approved.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'LEAVE HISTORY',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 35,
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/support.svg',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  Text(
                    'Support',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.black,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                final auth = FirebaseAuth.instance;
                auth.signOut().then((value) => {
                      if (auth.currentUser == null)
                        {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const AuthScreen(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                            (route) => false,
                          ),
                        }
                      else
                        {
                          // print('User still logged in'),
                        }
                    });
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logout.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'Log Out',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class endDrawerFaculty extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? role;
  final FacultyModel currentFaculty;
  const endDrawerFaculty(
      {super.key,
      required this.role,
      required this.currentFaculty,
      required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: ColorConstants.icongrey,
                    size: 30,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState?.closeEndDrawer();
                  },
                ),
              ],
            ),
            (role == 'faculty')
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentFaculty.name!,
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.black,
                          ),
                        ),
                        Text(
                          currentFaculty.designation!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.disabledText,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const HomeScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/home.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'HOME',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        PendingLeavesPage(
                      currentFaculty: currentFaculty,
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/timer.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'PENDING LEAVES',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.golden,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 35,
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/rejected.svg',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  Text(
                    'REJECTED LEAVES',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.red,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 35,
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/approved.svg',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  Text(
                    'APPROVED LEAVES',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.green,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 35,
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/support.svg',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  Text(
                    'Support',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.black,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                final auth = FirebaseAuth.instance;
                auth.signOut().then((value) => {
                      if (auth.currentUser == null)
                        {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const AuthScreen(),
                              transitionDuration: const Duration(seconds: 0),
                            ),
                            (route) => false,
                          ),
                        }
                      else
                        {
                          // print('User still logged in'),
                        }
                    });
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 35,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logout.svg',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      'Log Out',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: ColorConstants.disabledText,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
