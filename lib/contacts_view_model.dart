import 'package:flutter/material.dart';
import 'package:list_contatos_foto_dio/contacts_repository.dart';

import 'contacts_model.dart';

class ContactsVM {
  final listContacts = ValueNotifier([]);
  ContactRepopsitory repository = RepositoryImpl();

  void addContact(String name, String picture) {
    repository.createContact(ContactModel(picture: 'picture', name: 'name'));
    showContacts();
  }

  void editContact(String id) {}

  void showContacts() async {
    listContacts.value = await repository.getContacts();
  }
}
