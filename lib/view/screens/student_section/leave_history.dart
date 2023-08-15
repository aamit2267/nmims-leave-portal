import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/leave_model.dart';
import 'package:nmims_leave_portal/models/student_model.dart';
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
  List<LeaveModel> leaves = [];
  final auth = FirebaseAuth.instance;

  Future<void> getLeaveHistory() async {
    leaves.clear();
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();
    try {
      DocumentSnapshot student = await FirebaseFirestore.instance
          .collection('students')
          .doc(user.get('id'))
          .get();
      List<String> leavesId = [];
      for (var element in student.get('leaves')) {
        leavesId.add(element);
      }
      for (var element in leavesId) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('leaves')
            .doc(element)
            .get();
        leaves.add(LeaveModel(
          studentName: documentSnapshot.get('student_name'),
          studentSapId: documentSnapshot.get('student_sap_id'),
          studentRollNo: documentSnapshot.get('student_roll_no'),
          studentProgram: documentSnapshot.get('student_program'),
          studentBranch: documentSnapshot.get('student_branch'),
          studentSemester: documentSnapshot.get('student_semester'),
          studentEmail: documentSnapshot.get('student_email'),
          parentEmail: documentSnapshot.get('parent_email'),
          studentMobile: documentSnapshot.get('student_mobile'),
          parentMobile: documentSnapshot.get('parent_mobile'),
          homeAddress: documentSnapshot.get('home_address'),
          hostelRoomNo: documentSnapshot.get('hostel_room_no'),
          averageAttendance: documentSnapshot.get('average_attendance'),
          dateFrom: documentSnapshot.get('date_from'),
          dateTo: documentSnapshot.get('date_to'),
          totalDays: documentSnapshot.get('total_days'),
          totalAcademicDays: documentSnapshot.get('total_academic_days'),
          reason: documentSnapshot.get('reason'),
          leaveType: documentSnapshot.get('leave_type'),
          status: documentSnapshot.get('status'),
          createdAt: documentSnapshot.get('created_at'),
          id: documentSnapshot.id,
        ));
      }
      leaves = leaves.reversed.toList();
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
        endDrawer: endDrawerStudent(
          scaffoldKey: scaffoldKey,
          currentStudent: widget.currentStudent,
          role: 'student',
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
                            future: getLeaveHistory(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: leaves.length,
                                itemBuilder: (context, index) {
                                  if (leaves[index].status == 'APPROVED' ||
                                      leaves[index].status == 'REJECTED') {
                                    return leaveCard(
                                      leave: leaves[index],
                                    );
                                  } else if (leaves[index].status ==
                                          'PENDING' ||
                                      leaves[index].status ==
                                          'FORWARDED TO PROGRAM CHAIR' ||
                                      leaves[index].status ==
                                          'FORWARDED TO HOD') {
                                    leaves[index].status = 'PENDING';
                                    return leaveCard(
                                      leave: leaves[index],
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
