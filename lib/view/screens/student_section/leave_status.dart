import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/student_model.dart';
import 'package:nmims_leave_portal/store/app_store.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/widgets/end_drawer.dart';
import 'package:nmims_leave_portal/view/screens/student_section/widgets/leave_card.dart';
import 'package:nmims_leave_portal/view/widgets/app_bar.dart';

class LeaveStatusScreen extends StatefulWidget {
  final StudentModel currentStudent;
  const LeaveStatusScreen({super.key, required this.currentStudent});

  @override
  State<LeaveStatusScreen> createState() => _LeaveStatusScreenState();
}

class _LeaveStatusScreenState extends State<LeaveStatusScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final appStore = AppStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorConstants.white,
      endDrawer: endDrawerStudent(
        scaffoldKey,
        'student',
        widget.currentStudent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customAppBar(scaffoldKey),
            Text(
              'LEAVE STATUS',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: ColorConstants.black,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  leaveCard('PENDING'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
