// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$currentUserAtom =
      Atom(name: '_AppStore.currentUser', context: context);

  @override
  UserModel get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserModel value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('_AppStore.getUserData', context: context);

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$getStudentDataAsyncAction =
      AsyncAction('_AppStore.getStudentData', context: context);

  @override
  Future<void> getStudentData(dynamic sapId) {
    return _$getStudentDataAsyncAction.run(() => super.getStudentData(sapId));
  }

  late final _$getFacultyDataAsyncAction =
      AsyncAction('_AppStore.getFacultyData', context: context);

  @override
  Future<void> getFacultyData(dynamic id) {
    return _$getFacultyDataAsyncAction.run(() => super.getFacultyData(id));
  }

  late final _$applyLeaveAsyncAction =
      AsyncAction('_AppStore.applyLeave', context: context);

  @override
  Future<void> applyLeave(LeaveModel leave) {
    return _$applyLeaveAsyncAction.run(() => super.applyLeave(leave));
  }

  late final _$getPendingLeavesAsyncAction =
      AsyncAction('_AppStore.getPendingLeaves', context: context);

  @override
  Future<void> getPendingLeaves() {
    return _$getPendingLeavesAsyncAction.run(() => super.getPendingLeaves());
  }

  late final _$updateLeaveStatusAsyncAction =
      AsyncAction('_AppStore.updateLeaveStatus', context: context);

  @override
  Future<void> updateLeaveStatus(LeaveModel leave, String status) {
    return _$updateLeaveStatusAsyncAction
        .run(() => super.updateLeaveStatus(leave, status));
  }

  late final _$getLeaveHistoryAsyncAction =
      AsyncAction('_AppStore.getLeaveHistory', context: context);

  @override
  Future<void> getLeaveHistory() {
    return _$getLeaveHistoryAsyncAction.run(() => super.getLeaveHistory());
  }

  late final _$getLastLeaveStatusAsyncAction =
      AsyncAction('_AppStore.getLastLeaveStatus', context: context);

  @override
  Future<void> getLastLeaveStatus() {
    return _$getLastLeaveStatusAsyncAction
        .run(() => super.getLastLeaveStatus());
  }

  late final _$signInAsyncAction =
      AsyncAction('_AppStore.signIn', context: context);

  @override
  Future<void> signIn(dynamic email, dynamic password) {
    return _$signInAsyncAction.run(() => super.signIn(email, password));
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser}
    ''';
  }
}
