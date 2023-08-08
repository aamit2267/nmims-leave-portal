import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/faculty_model.dart';
import 'package:nmims_leave_portal/store/app_store.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/widgets/leave_card.dart';
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
  final appStore = AppStore();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorConstants.white,
      endDrawer: endDrawerStudent(
        scaffoldKey,
        'faculty',
        widget.currentFaculty,
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
            FutureBuilder(
              future: appStore.getPendingLeaves(),
              builder: (context, snapshot) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appStore.leaves.length,
                  itemBuilder: (context, index) {
                    return leaveCard(
                      leave: appStore.leaves[index],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
