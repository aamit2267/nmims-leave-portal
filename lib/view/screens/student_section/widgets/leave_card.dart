// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/leave_model.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';

class leaveCard extends StatelessWidget {
  final LeaveModel leave;
  const leaveCard({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> statusColor = {
      'APPROVED': ColorConstants.green,
      'PENDING': ColorConstants.golden,
      'REJECTED': ColorConstants.red,
    };
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 40,
        right: 40,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(43),
        color: ColorConstants.offwhite,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${leave.studentName}',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.black,
            ),
          ),
          Text(
            'SAP ID: ${leave.studentSapId}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'Roll No.: ${leave.studentRollNo}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            "${leave.studentProgram!} ${leave.studentBranch!}",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'Sem: - ${leave.studentSemester!}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'From: - ${leave.dateFrom!}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'To: - ${leave.dateTo!}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'No. of Days: - ${leave.totalDays!}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'No. Acad. of Days: - ${leave.totalAcademicDays!}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'Reason: - ${leave.reason!}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 50,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorConstants.black,
                ),
              ),
              child: Center(
                  child: Text(
                leave.status!,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: statusColor[leave.status!],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
