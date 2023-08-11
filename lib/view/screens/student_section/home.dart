import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/student_section/apply_leave.dart';
import 'package:nmims_leave_portal/view/screens/student_section/leave_history.dart';
import 'package:nmims_leave_portal/view/screens/student_section/leave_status.dart';

Widget studentHome(context, currentStudent) {
  return Column(
    children: [
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
          height: 70,
          margin: const EdgeInsets.only(
            top: 52,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.golden,
            border: Border.all(
              color: ColorConstants.black,
            ),
          ),
          child: Center(
            child: Text(
              'APPLY FOR LEAVE',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorConstants.white,
              ),
            ),
          ),
        ),
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
          height: 70,
          margin: const EdgeInsets.only(
            top: 34,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.red,
            border: Border.all(
              color: ColorConstants.black,
            ),
          ),
          child: Center(
            child: Text(
              'LEAVE STATUS',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorConstants.white,
              ),
            ),
          ),
        ),
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
          height: 70,
          margin: const EdgeInsets.only(
            top: 34,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.green,
            border: Border.all(
              color: ColorConstants.black,
            ),
          ),
          child: Center(
            child: Text(
              'LEAVE HISTORY',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorConstants.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
