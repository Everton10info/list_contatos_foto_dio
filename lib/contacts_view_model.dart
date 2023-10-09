import 'package:flutter/material.dart';
import 'package:list_contatos_foto_dio/contacts_repository.dart';
import 'contacts_model.dart';

class ContactsVM {
  final listContacts = ValueNotifier([]);

  ContactRepopsitory repository = RepositoryImpl();

  void addContact(String name, String picture) async {
    await repository.createContact(ContactModel(picture: picture, name: name));
    await showContacts();
  }

  void editContact(String id) {}

  Future<void> showContacts() async {
    await Future.delayed(const Duration(seconds: 1));
    listContacts.value = await repository.getContacts();
  }

  void deleteContact(String id) async {
    await repository.deleteContacts(id);
    await showContacts();
  }
}
