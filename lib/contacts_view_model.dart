import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:list_contatos_foto_dio/contacts_repository.dart';
import 'cam_services.dart';
import 'contacts_model.dart';

class ContactsVM extends ChangeNotifier {
  List<ContactModel> listContacts = [];
  ContactRepopsitory repository = RepositoryImpl();
  XFile? file;

  void takePhoto() async {
    file = await ImagePickerCustomer.take();
    notifyListeners();
  }

  void addContact(String name, String picture) async {
    await repository.createContact(ContactModel(picture: picture, name: name));
    await showContacts();
  }

  void editContact(String name, String picture, String id) {
    ContactModel contactModel = ContactModel(
      picture: picture,
      name: name,
      objectId: id,
    );
    repository.editContact(contactModel);
    showContacts();
  }

  Future<void> showContacts() async {
    await Future.delayed(const Duration(seconds: 1));
    listContacts = await repository.getContacts();
    notifyListeners();
  }

  void deleteContact(String id) async {
    repository.deleteContacts(id);
    await showContacts();
  }
}
