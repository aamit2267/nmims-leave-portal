import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nmims_leave_portal/models/faculty_model.dart';
import 'package:nmims_leave_portal/models/student_model.dart';
import 'package:nmims_leave_portal/models/user_model.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/faculty_section/home.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/widgets/end_drawer.dart';
import 'package:nmims_leave_portal/view/screens/student_section/home.dart';
import 'package:nmims_leave_portal/view/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formatter = NumberFormat('00');
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  UserModel currentUser = UserModel();
  StudentModel currentStudent = StudentModel();
  FacultyModel currentFaculty = FacultyModel();

  Future<void> getUserData() async {
    currentUser.uid = auth.currentUser!.uid;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    if (documentSnapshot.exists) {
      currentUser.id = documentSnapshot.get('id');
      currentUser.role = documentSnapshot.get('role');
      if (currentUser.role == 'student') {
        await getStudentData(currentUser.id);
      } else {
        await getFacultyData(currentUser.id);
      }
    }
  }

  Future<void> getStudentData(sapId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(sapId)
        .get();

    if (documentSnapshot.exists) {
      currentStudent.name = documentSnapshot.get('name');
      currentStudent.sapId = documentSnapshot.get('sap_id');
      currentStudent.rollNo = documentSnapshot.get('roll_no');
      currentStudent.program = documentSnapshot.get('program');
      currentStudent.branch = documentSnapshot.get('branch');
    }
  }

  Future<void> getFacultyData(id) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('faculties').doc(id).get();

    if (documentSnapshot.exists) {
      currentFaculty.name = documentSnapshot.get('name');
      currentFaculty.designation = documentSnapshot.get('designation');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (scaffoldKey.currentState!.isEndDrawerOpen) {
          scaffoldKey.currentState?.closeEndDrawer();
          return false;
        } else {
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        backgroundColor: ColorConstants.white,
        endDrawer: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (currentUser.role == 'student') {
                return endDrawerStudent(
                  scaffoldKey: scaffoldKey,
                  role: currentUser.role,
                  currentStudent: currentStudent,
                );
              } else {
                return endDrawerFaculty(
                  scaffoldKey: scaffoldKey,
                  role: currentUser.role,
                  currentFaculty: currentFaculty,
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              customAppBar(scaffoldKey),
              Center(
                child: Text(
                  '${formatter.format(DateTime.now().day)}.${formatter.format(DateTime.now().month)}.${DateTime.now().year}',
                  style: GoogleFonts.inter(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.black,
                  ),
                ),
              ),
              Center(
                child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      '${formatter.format(DateTime.now().hour > 12 ? DateTime.now().hour - 12 : DateTime.now().hour)}:${formatter.format(DateTime.now().minute)} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (currentUser.role == 'student') {
                      return studentHome(context, currentStudent);
                    } else {
                      return facultyHome(context, currentFaculty);
                    }
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
