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

  late final _$signOutAsyncAction =
      AsyncAction('_AppStore.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
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
