// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:nmims_leave_portal/models/faculty_model.dart';
import 'package:nmims_leave_portal/models/leave_model.dart';
import 'package:nmims_leave_portal/models/student_model.dart';
import 'package:nmims_leave_portal/models/user_model.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  final auth = FirebaseAuth.instance;

  @observable
  UserModel currentUser = UserModel();
  StudentModel currentStudent = StudentModel();
  FacultyModel currentFaculty = FacultyModel();
  String role = '';
  List<LeaveModel> leaves = [];

  @action
  Future<void> getUserData() async {
    currentUser.uid = auth.currentUser!.uid;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    if (documentSnapshot.exists) {
      currentUser.id = documentSnapshot.get('id');
      currentUser.role = documentSnapshot.get('role');
      role = documentSnapshot.get('role');

      if (currentUser.role == 'student') {
        await getStudentData(currentUser.id);
      } else {
        await getFacultyData(currentUser.id);
      }
    }
  }

  @action
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

  @action
  Future<void> getFacultyData(id) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('faculties').doc(id).get();

    if (documentSnapshot.exists) {
      currentFaculty.name = documentSnapshot.get('name');
      currentFaculty.designation = documentSnapshot.get('designation');
    }
  }

  @action
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
      'mentorId': currentStudent.mentorId,
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(leave.studentSapId)
          .update({
        'leaves': FieldValue.arrayUnion([value.id])
      });
    });
  }

  @action
  Future<void> getPendingLeaves() async {
    leaves.clear();

    List<String> mentees = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('faculties')
        .where('mentor_id', isEqualTo: currentUser.id)
        .get();
    for (var element in querySnapshot.docs) {
      mentees = List.from(element.get('mentees'));
    }

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
  }

  @action
  Future<void> updateLeaveStatus(LeaveModel leave, String status) async {
    await FirebaseFirestore.instance
        .collection('leaves')
        .doc(leave.id)
        .update({'status': status});
  }

  @action
  Future<void> signOut() async {
    await auth.signOut();
  }

  @action
  Future<void> signIn(email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
