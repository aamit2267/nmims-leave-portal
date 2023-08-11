// ignore_for_file: deprecated_member_use, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/faculty_model.dart';
import 'package:nmims_leave_portal/models/leave_model.dart';
import 'package:nmims_leave_portal/store/app_store.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/pending_leaves.dart';
import 'package:url_launcher/url_launcher.dart';

class leaveCardPC extends StatefulWidget {
  final LeaveModel leave;
  final AppStore appStore;
  final FacultyModel currentFaculty;
  const leaveCardPC(
      {super.key,
      required this.leave,
      required this.appStore,
      required this.currentFaculty});

  @override
  State<leaveCardPC> createState() => _leaveCardPCState();
}

class _leaveCardPCState extends State<leaveCardPC> {
  bool phone = false;
  bool mail = false;

  Widget forwardButton() {
    return GestureDetector(
      onTap: () {
        widget.appStore.updateLeaveStatus(widget.leave, "FORWARDED TO HOD");
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PendingLeavesPage(currentFaculty: widget.currentFaculty),
            transitionDuration: const Duration(seconds: 0),
          ),
        );
        Fluttertoast.showToast(
          msg: 'FORWARDED TO HOD',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstants.golden,
          textColor: ColorConstants.white,
          fontSize: 16.0,
        );
      },
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
    );
  }

  Widget approveButton() {
    return GestureDetector(
      onTap: () {
        widget.appStore.updateLeaveStatus(widget.leave, "APPROVED");
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PendingLeavesPage(currentFaculty: widget.currentFaculty),
            transitionDuration: const Duration(seconds: 0),
          ),
        );
        Fluttertoast.showToast(
          msg: 'APPROVED LEAVE',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorConstants.golden,
          textColor: ColorConstants.white,
          fontSize: 16.0,
        );
      },
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
          color: ColorConstants.green,
          border: Border.all(
            color: ColorConstants.black,
          ),
        ),
        child: Center(
          child: Text(
            'APPROVED',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorConstants.white,
            ),
          ),
        ),
      ),
    );
  }

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
      child: SingleChildScrollView(
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
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: phone,
                      onChanged: (val) {
                        setState(() {
                          phone = val!;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Text(
                      'Parents Call',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: mail,
                      onChanged: (val) {
                        setState(() {
                          mail = val!;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorConstants.white,
                border: Border.all(
                  color: ColorConstants.black,
                ),
              ),
              child: TextField(
                controller: null,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Remarks',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
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
                (int.parse(widget.leave.totalAcademicDays!) <= 2)
                    ? approveButton()
                    : forwardButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
