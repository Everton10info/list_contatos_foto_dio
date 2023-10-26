import 'package:image_picker/image_picker.dart';
import 'package:list_contatos_foto_dio/repositories/auth_repository.dart';
import 'package:list_contatos_foto_dio/repositories/contacts_repository.dart';
import 'package:list_contatos_foto_dio/services/auth_service.dart';
import 'package:mobx/mobx.dart';
import '../services/cam_services.dart';
import '../models/contacts_model.dart';

part 'contacts_controller.g.dart';

// ignore: library_private_types_in_public_api
class ControllerContacts = _ControllerContacts with _$ControllerContacts;

abstract class _ControllerContacts with Store {
  @observable
  List<ContactModel> listContacts = [];

  ContactRepopsitory repository = RepositoryImpl();
  @observable
  XFile? file;

  @observable
  bool loader = true;

  @action
  Future<void> takePhoto() async {
    file = await ImagePickerCustomer.take();
  }

  @action
  void loaderChange(bool boolean) {
    loader = boolean;
  }

  void addContact(String name, String picture) async {
    loaderChange(true);
    await repository.createContact(ContactModel(picture: picture, name: name));

    await showContacts();
  }

  void editContact(String name, String picture, String id) {
    loaderChange(true);
    ContactModel contactModel = ContactModel(
      picture: picture,
      name: name,
      objectId: id,
    );
    repository.editContact(contactModel);
    showContacts();
  }

  @action
  Future<void> showContacts() async {
    await Future.delayed(const Duration(seconds: 1));
    listContacts = await repository.getContacts();
    loaderChange(false);
  }

  void deleteContact(String id) async {
    repository.deleteContacts(id);
    await showContacts();
  }

  void logOut() async {
    var rep = AuthRepositoryImpl(service: AuthService());
    rep.logOut();
  }
}
