// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerContacts on _ControllerContacts, Store {
  late final _$listContactsAtom =
      Atom(name: '_ControllerContacts.listContacts', context: context);

  @override
  List<ContactModel> get listContacts {
    _$listContactsAtom.reportRead();
    return super.listContacts;
  }

  @override
  set listContacts(List<ContactModel> value) {
    _$listContactsAtom.reportWrite(value, super.listContacts, () {
      super.listContacts = value;
    });
  }

  late final _$fileAtom =
      Atom(name: '_ControllerContacts.file', context: context);

  @override
  XFile? get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(XFile? value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  late final _$loaderAtom =
      Atom(name: '_ControllerContacts.loader', context: context);

  @override
  bool get loader {
    _$loaderAtom.reportRead();
    return super.loader;
  }

  @override
  set loader(bool value) {
    _$loaderAtom.reportWrite(value, super.loader, () {
      super.loader = value;
    });
  }

  late final _$takePhotoAsyncAction =
      AsyncAction('_ControllerContacts.takePhoto', context: context);

  @override
  Future<void> takePhoto() {
    return _$takePhotoAsyncAction.run(() => super.takePhoto());
  }

  late final _$showContactsAsyncAction =
      AsyncAction('_ControllerContacts.showContacts', context: context);

  @override
  Future<void> showContacts() {
    return _$showContactsAsyncAction.run(() => super.showContacts());
  }

  late final _$_ControllerContactsActionController =
      ActionController(name: '_ControllerContacts', context: context);

  @override
  void loaderChange(bool boolean) {
    final _$actionInfo = _$_ControllerContactsActionController.startAction(
        name: '_ControllerContacts.loaderChange');
    try {
      return super.loaderChange(boolean);
    } finally {
      _$_ControllerContactsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listContacts: ${listContacts},
file: ${file},
loader: ${loader}
    ''';
  }
}
