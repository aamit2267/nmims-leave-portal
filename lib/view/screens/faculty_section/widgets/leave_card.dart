// ignore_for_file: deprecated_member_use, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/leave_model.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class leaveCard extends StatefulWidget {
  final LeaveModel leave;
  const leaveCard({super.key, required this.leave});

  @override
  State<leaveCard> createState() => _leaveCardState();
}

class _leaveCardState extends State<leaveCard> {
  bool phone = false;
  bool mail = false;
  @override
  Widget build(BuildContext context) {
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
            widget.leave.studentName!,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: ColorConstants.black,
            ),
          ),
          Text(
            widget.leave.studentSapId!,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            widget.leave.studentRollNo!,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            "${widget.leave.studentProgram!} ${widget.leave.studentBranch!}",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'Sem: - ${widget.leave.studentSemester!}',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'From: - ${widget.leave.dateFrom!}',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'To: - ${widget.leave.dateTo!}',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'No. of Days: - ${widget.leave.totalDays!}',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            'Reason: - ${widget.leave.reason!}',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              launch("tel://${widget.leave.parentMobile!}");
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorConstants.green,
                border: Border.all(
                  color: ColorConstants.black,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Call Parents',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Confirmation: -',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorConstants.black,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: phone,
                onChanged: (val) {
                  setState(() {
                    phone = val!;
                  });
                },
              ),
              Text(
                'Parents Call',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.black,
                ),
              ),
              Checkbox(
                value: mail,
                onChanged: (val) {
                  setState(() {
                    mail = val!;
                  });
                },
              ),
              Text(
                'Parents Mail',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 60,
                  width: 130,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
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
                      'REJECT',
                      style: GoogleFonts.inter(
                        fontSize: 12,
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
                  height: 60,
                  width: 130,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
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
                      'FORWARD',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
