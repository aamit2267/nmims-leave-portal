import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/pending_leaves.dart';

Widget facultyHome(context, currentFaculty) {
  return Column(
    children: [
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
              'PENDING LEAVES',
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
        onTap: () {},
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
              'REJECTED LEAVES',
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
        onTap: () {},
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
              'APPROVED LEAVES',
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
