import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';

Widget leaveCard(String status) {
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
          'Amit Agarwal',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: ColorConstants.black,
          ),
        ),
        Text(
          '70552100002',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.grey,
          ),
        ),
        Text(
          'E201',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.grey,
          ),
        ),
        Row(
          children: [
            Text(
              'B.TECH',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ColorConstants.grey,
              ),
            ),
            Text(
              'CS',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ColorConstants.grey,
              ),
            ),
          ],
        ),
        Text(
          'Sem: - V',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.grey,
          ),
        ),
        Text(
          'From: - 20/07/2023',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.grey,
          ),
        ),
        Text(
          'To: - 30/07/2023',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.grey,
          ),
        ),
        Text(
          'No. of Days: - 10',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.grey,
          ),
        ),
        Text(
          'Reason: - Going to home',
          style: GoogleFonts.inter(
            fontSize: 18,
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
              status,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: statusColor[status],
              ),
            )),
          ),
        ),
      ],
    ),
  );
}
