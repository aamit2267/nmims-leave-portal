import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmims_leave_portal/models/leave_model.dart';
import 'package:nmims_leave_portal/models/student_model.dart';
import 'package:nmims_leave_portal/models/user_model.dart';
import 'package:nmims_leave_portal/theme/color_constants.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/home_screen.dart';
import 'package:nmims_leave_portal/view/screens/home_screen/widgets/end_drawer.dart';
import 'package:nmims_leave_portal/view/widgets/app_bar.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

final Map<String, TextEditingController> _controllers = {
  'name': TextEditingController(),
  'sap_id': TextEditingController(),
  'roll_no': TextEditingController(),
  'program': TextEditingController(),
  'branch': TextEditingController(),
  'sem': TextEditingController(),
  'email_id_self': TextEditingController(),
  'email_id_parents': TextEditingController(),
  'mob_no_self': TextEditingController(),
  'contact_no_parents': TextEditingController(),
  'home_address': TextEditingController(),
  'hostel_room_no': TextEditingController(),
  'average_attendance': TextEditingController(),
  'from': TextEditingController(),
  'to': TextEditingController(),
  'total_days': TextEditingController(),
  'total_academic_days': TextEditingController(),
  'reason': TextEditingController(),
};
int leaveType = 0;

Future<void> applyLeave(LeaveModel leave) async {
  await FirebaseFirestore.instance.collection('leaves').add({
    'student_name': leave.studentName,
    'student_sap_id': leave.studentSapId,
    'student_roll_no': leave.studentRollNo,
    'student_program': leave.studentProgram,
    'student_branch': leave.studentBranch,
    'student_semester': leave.studentSemester,
    'student_email': leave.studentEmail,
    'parent_email': leave.parentEmail,
    'student_mobile': leave.studentMobile,
    'parent_mobile': leave.parentMobile,
    'home_address': leave.homeAddress,
    'hostel_room_no': leave.hostelRoomNo,
    'average_attendance': leave.averageAttendance,
    'date_from': leave.dateFrom,
    'date_to': leave.dateTo,
    'total_days': leave.totalDays,
    'total_academic_days': leave.totalAcademicDays,
    'reason': leave.reason,
    'leave_type': leave.leaveType,
    'status': leave.status,
    'created_at': leave.createdAt,
    'isParentCall': false,
    'isParentMail': false,
    'remark': '',
  }).then((value) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(leave.studentSapId)
        .update({
      'leaves': FieldValue.arrayUnion([value.id])
    });
  });
}

class ApplyLeaveScreen extends StatefulWidget {
  final StudentModel currentStudent;
  const ApplyLeaveScreen({super.key, required this.currentStudent});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel currentUser = UserModel();
  StudentModel currentStudent = StudentModel();
  final auth = FirebaseAuth.instance;

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

  @override
  void initState() {
    getUserData();
    _controllers['name']!.text = widget.currentStudent.name!;
    _controllers['sap_id']!.text = widget.currentStudent.sapId!;
    _controllers['roll_no']!.text = widget.currentStudent.rollNo!;
    _controllers['program']!.text = widget.currentStudent.program!;
    _controllers['branch']!.text = widget.currentStudent.branch!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        for (var i = 0; i < _controllers.length; i++) {
          _controllers.values.elementAt(i).text = '';
        }
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
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: ColorConstants.white,
        endDrawer: endDrawerStudent(
          scaffoldKey: scaffoldKey,
          currentStudent: widget.currentStudent,
          role: 'student',
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customAppBar(scaffoldKey),
              Text(
                'APPLY LEAVE',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.black,
                ),
              ),
              form(_controllers, context, setState),
            ],
          ),
        ),
      ),
    );
  }
}

Widget form(controllers, context, setState) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 26,
              left: 20,
              right: 20,
            ),
            width: 343,
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
              children: [
                customTextField(
                  'Name',
                  true,
                  controllers['name'],
                  TextInputType.name,
                ),
                customTextField(
                  'SAP ID',
                  true,
                  controllers['sap_id'],
                  TextInputType.number,
                ),
                customTextField(
                  'Roll No.',
                  true,
                  controllers['roll_no'],
                  TextInputType.text,
                ),
                customTextField(
                  'Program',
                  true,
                  controllers['program'],
                  TextInputType.text,
                ),
                customTextField(
                  'Branch',
                  true,
                  controllers['branch'],
                  TextInputType.text,
                ),
                semSelector(context),
                customTextField(
                  'Email ID (Self)',
                  false,
                  controllers['email_id_self'],
                  TextInputType.emailAddress,
                ),
                customTextField(
                  'Email ID (Parents)',
                  false,
                  controllers['email_id_parents'],
                  TextInputType.emailAddress,
                ),
                customTextField(
                  'Mob No. (Self)',
                  false,
                  controllers['mob_no_self'],
                  TextInputType.phone,
                ),
                customTextField(
                  'Contact No. (Parents)',
                  false,
                  controllers['contact_no_parents'],
                  TextInputType.phone,
                ),
                customTextField(
                  'Home Address',
                  false,
                  controllers['home_address'],
                  TextInputType.text,
                ),
                customTextField(
                  'Hostel Room No.',
                  false,
                  controllers['hostel_room_no'],
                  TextInputType.text,
                ),
                customTextField(
                  'Average Attendance (%)',
                  false,
                  controllers['average_attendance'],
                  TextInputType.number,
                ),
                customDatePicker(
                  'From',
                  true,
                  controllers['from'],
                  context,
                ),
                customDatePicker(
                  'To',
                  true,
                  controllers['to'],
                  context,
                ),
                customTextField(
                  'Total No. of Days',
                  false,
                  controllers['total_days'],
                  TextInputType.number,
                ),
                customTextField(
                  'Total No. of Academic Days',
                  false,
                  controllers['total_academic_days'],
                  TextInputType.number,
                ),
                customTextField(
                  'Reason for Leave',
                  false,
                  controllers['reason'],
                  TextInputType.text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 25,
                      child: Radio(
                        value: 0,
                        groupValue: leaveType,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) {
                          leaveType = 0;
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      'Authorized Leave',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 25,
                      child: Radio(
                        value: 1,
                        groupValue: leaveType,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) {
                          leaveType = 1;
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      'Special Leave',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 65,
              right: 65,
              bottom: 30,
            ),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                for (var i = 0; i < _controllers.length; i++) {
                  if (_controllers.values.elementAt(i).text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Please fill all the fields',
                      backgroundColor: ColorConstants.mehroon,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                    );
                    return;
                  }
                }
                LeaveModel leave = LeaveModel();
                leave.studentName = _controllers['name']!.text;
                leave.studentSapId = _controllers['sap_id']!.text;
                leave.studentRollNo = _controllers['roll_no']!.text;
                leave.studentProgram = _controllers['program']!.text;
                leave.studentBranch = _controllers['branch']!.text;
                leave.studentSemester = _controllers['sem']!.text;
                leave.studentEmail = _controllers['email_id_self']!.text;
                leave.parentEmail = _controllers['email_id_parents']!.text;
                leave.studentMobile = _controllers['mob_no_self']!.text;
                leave.parentMobile = _controllers['contact_no_parents']!.text;
                leave.homeAddress = _controllers['home_address']!.text;
                leave.hostelRoomNo = _controllers['hostel_room_no']!.text;
                leave.averageAttendance =
                    _controllers['average_attendance']!.text;
                leave.dateFrom = _controllers['from']!.text;
                leave.dateTo = _controllers['to']!.text;
                leave.totalDays = _controllers['total_days']!.text;
                leave.totalAcademicDays =
                    _controllers['total_academic_days']!.text;
                leave.reason = _controllers['reason']!.text;
                leave.leaveType = leaveType == 0 ? 'authorized' : 'special';
                leave.status = 'PENDING';
                leave.createdAt = DateTime.now().toString();
                applyLeave(leave);

                for (var i = 0; i < _controllers.length; i++) {
                  _controllers.values.elementAt(i).text = '';
                }

                Fluttertoast.showToast(
                  msg: 'Leave Applied Successfully',
                  backgroundColor: ColorConstants.green,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                );

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.green,
                foregroundColor: ColorConstants.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),
                  side: const BorderSide(
                    color: ColorConstants.black,
                  ),
                ),
              ),
              child: Text(
                'APPLY',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget semSelector(context) {
  List<String> semesters = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
  ];
  return Container(
    margin: const EdgeInsets.only(
      top: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sem',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstants.black,
          ),
        ),
        TextField(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              builder: (context) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Select Semester',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.black,
                        ),
                      ),
                      const Divider(
                        color: ColorConstants.black,
                        thickness: 1,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: semesters.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                _controllers['sem']!.text = semesters[index];
                                Navigator.pop(context);
                              },
                              title: Column(
                                children: [
                                  Text(
                                    semesters[index],
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.black,
                                    ),
                                  ),
                                  const Divider(
                                    color: ColorConstants.black,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          controller: _controllers['sem'],
          readOnly: true,
          cursorColor: Colors.black,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorConstants.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ColorConstants.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ColorConstants.black,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: ColorConstants.white,
            filled: true,
          ),
        ),
      ],
    ),
  );
}

Widget customTextField(String label, bool readOnly,
    TextEditingController controller, TextInputType keyboardType) {
  return Container(
    margin: const EdgeInsets.only(
      top: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstants.black,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: (keyboardType == TextInputType.phone) ? 10 : null,
          buildCounter: (BuildContext context,
                  {required int currentLength,
                  required bool isFocused,
                  required int? maxLength}) =>
              null,
          readOnly: readOnly,
          cursorColor: Colors.black,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color:
                readOnly ? ColorConstants.disabledText : ColorConstants.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: (keyboardType == TextInputType.emailAddress &&
                        controller.text.isNotEmpty &&
                        !controller.text.contains('@'))
                    ? ColorConstants.red
                    : ColorConstants.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: (keyboardType == TextInputType.emailAddress &&
                        controller.text.isNotEmpty &&
                        !controller.text.contains('@'))
                    ? ColorConstants.red
                    : ColorConstants.black,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: readOnly
                ? ColorConstants.disabledContainer
                : ColorConstants.white,
            filled: true,
          ),
        ),
      ],
    ),
  );
}

Widget customDatePicker(
    String label, bool readOnly, TextEditingController controller, context) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return Container(
    margin: const EdgeInsets.only(
      top: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstants.black,
          ),
        ),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: () async {
            if (label == 'From') {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                controller.text = formatter.format(picked);
              }
            }
            if (label == 'To') {
              try {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: formatter.parse(_controllers['from']!.text).add(
                        const Duration(days: 1),
                      ),
                  firstDate: formatter.parse(_controllers['from']!.text).add(
                        const Duration(days: 1),
                      ),
                  lastDate: formatter
                      .parse(_controllers['from']!.text)
                      .add(const Duration(days: 365)),
                );
                if (picked != null) {
                  controller.text = formatter.format(picked);
                  _controllers['total_days']!.text = (picked
                          .difference(
                              formatter.parse(_controllers['from']!.text))
                          .inDays)
                      .toString();
                }
              } catch (e) {
                Fluttertoast.showToast(
                  msg: 'Please select From date first',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                );
              }
            }
          },
          cursorColor: Colors.black,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorConstants.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: const Icon(
              Icons.calendar_today,
              color: ColorConstants.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ColorConstants.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ColorConstants.black,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: ColorConstants.white,
            filled: true,
          ),
        ),
      ],
    ),
  );
}
