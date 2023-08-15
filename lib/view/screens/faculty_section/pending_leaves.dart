import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/faculty_model.dart';
import 'package:nmims_leave_portal/models/leave_model.dart';
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
  List<LeaveModel> leaves = [];
  final auth = FirebaseAuth.instance;

  Future<void> getPendingLeaves() async {
    leaves.clear();
    List<String> mentees = [];
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('faculties')
          .doc(user.get('id'))
          .get();
      mentees = List.from(documentSnapshot.get('mentees'));

      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('leaves')
          .where('student_sap_id', whereIn: mentees)
          .where('status', isEqualTo: 'PENDING')
          .get();
      for (var element in querySnapshot2.docs) {
        leaves.add(LeaveModel(
          studentName: element.get('student_name'),
          studentSapId: element.get('student_sap_id'),
          studentRollNo: element.get('student_roll_no'),
          studentProgram: element.get('student_program'),
          studentBranch: element.get('student_branch'),
          studentSemester: element.get('student_semester'),
          studentEmail: element.get('student_email'),
          parentEmail: element.get('parent_email'),
          studentMobile: element.get('student_mobile'),
          parentMobile: element.get('parent_mobile'),
          homeAddress: element.get('home_address'),
          hostelRoomNo: element.get('hostel_room_no'),
          averageAttendance: element.get('average_attendance'),
          dateFrom: element.get('date_from'),
          dateTo: element.get('date_to'),
          totalDays: element.get('total_days'),
          totalAcademicDays: element.get('total_academic_days'),
          reason: element.get('reason'),
          leaveType: element.get('leave_type'),
          status: element.get('status'),
          createdAt: element.get('created_at'),
          id: element.id,
        ));
      }
    } catch (e) {
      // null
    }
    try {
      DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
          .collection('programchair')
          .doc(user.get('id'))
          .get();
      String branch = documentSnapshot2.get('branch');
      QuerySnapshot querySnapshot3 = await FirebaseFirestore.instance
          .collection('leaves')
          .where('student_branch', isEqualTo: branch)
          .where('status', isEqualTo: 'FORWARDED TO PROGRAM CHAIR')
          .get();
      for (var element in querySnapshot3.docs) {
        leaves.add(LeaveModel(
          studentName: element.get('student_name'),
          studentSapId: element.get('student_sap_id'),
          studentRollNo: element.get('student_roll_no'),
          studentProgram: element.get('student_program'),
          studentBranch: element.get('student_branch'),
          studentSemester: element.get('student_semester'),
          studentEmail: element.get('student_email'),
          parentEmail: element.get('parent_email'),
          studentMobile: element.get('student_mobile'),
          parentMobile: element.get('parent_mobile'),
          homeAddress: element.get('home_address'),
          hostelRoomNo: element.get('hostel_room_no'),
          averageAttendance: element.get('average_attendance'),
          dateFrom: element.get('date_from'),
          dateTo: element.get('date_to'),
          totalDays: element.get('total_days'),
          totalAcademicDays: element.get('total_academic_days'),
          reason: element.get('reason'),
          leaveType: element.get('leave_type'),
          status: element.get('status'),
          createdAt: element.get('created_at'),
          id: element.id,
          isParentCall: element.get('isParentCall'),
          isParentEmail: element.get('isParentMail'),
          remark: element.get('remark'),
        ));
      }
    } catch (e) {
      // null
    }
    try {
      DocumentSnapshot documentSnapshot3 = await FirebaseFirestore.instance
          .collection('HOD')
          .doc(user.get('id'))
          .get();
      String program = documentSnapshot3.get('program');
      QuerySnapshot querySnapshot4 = await FirebaseFirestore.instance
          .collection('leaves')
          .where('student_program', isEqualTo: program)
          .where('status', isEqualTo: 'FORWARDED TO HOD')
          .get();
      for (var element in querySnapshot4.docs) {
        leaves.add(LeaveModel(
          studentName: element.get('student_name'),
          studentSapId: element.get('student_sap_id'),
          studentRollNo: element.get('student_roll_no'),
          studentProgram: element.get('student_program'),
          studentBranch: element.get('student_branch'),
          studentSemester: element.get('student_semester'),
          studentEmail: element.get('student_email'),
          parentEmail: element.get('parent_email'),
          studentMobile: element.get('student_mobile'),
          parentMobile: element.get('parent_mobile'),
          homeAddress: element.get('home_address'),
          hostelRoomNo: element.get('hostel_room_no'),
          averageAttendance: element.get('average_attendance'),
          dateFrom: element.get('date_from'),
          dateTo: element.get('date_to'),
          totalDays: element.get('total_days'),
          totalAcademicDays: element.get('total_academic_days'),
          reason: element.get('reason'),
          leaveType: element.get('leave_type'),
          status: element.get('status'),
          createdAt: element.get('created_at'),
          id: element.id,
          isParentCall: element.get('isParentCall'),
          isParentEmail: element.get('isParentMail'),
          remark: element.get('remark'),
        ));
      }
    } catch (e) {
      // null
    }
  }

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
                            future: getPendingLeaves(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaves.length,
                                itemBuilder: (context, index) {
                                  if (leaves[index].status == 'PENDING') {
                                    return leaveCard(
                                      leave: leaves[index],
                                      currentFaculty: widget.currentFaculty,
                                    );
                                  } else if (leaves[index].status ==
                                      'FORWARDED TO PROGRAM CHAIR') {
                                    return leaveCardPC(
                                      leave: leaves[index],
                                      currentFaculty: widget.currentFaculty,
                                    );
                                  } else if (leaves[index].status ==
                                      'FORWARDED TO HOD') {
                                    return leaveCardHOD(
                                      leave: leaves[index],
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
