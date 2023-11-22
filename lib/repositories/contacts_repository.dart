import 'package:dio/dio.dart';

import '../models/contacts_model.dart';
import '../shared/config/configs.dart';
import '../shared/exceptions/exceptions.dart';
import '../shared/utils/check_connection.dart';

abstract interface class ContactRepopsitory {
  Future<void> createContact(ContactModel contact);
  Future<List<ContactModel>> getContacts();
  void deleteContacts(String id);
  void editContact(ContactModel contact);
}

class RepositoryImpl implements ContactRepopsitory {
  final String baseUrl = Config.baseUrl;
  final headers = {
    'X-Parse-Application-Id': Config.aplicationId,
    'X-Parse-REST-API-Key': Config.apiKey,
    'Content-Type': 'application/json'
  };
  Dio dio = Dio();
  @override
  deleteContacts(String id) async {
      if (await CheckConnection.isConnected == false)throw AppExceptionConnect();
    await dio.delete(
      '$baseUrl/$id',
      options: Options(headers: headers),
    );
  }

  @override
  editContact(ContactModel contact) async {
      if (await CheckConnection.isConnected == false)throw AppExceptionConnect();
    await dio.put(
      data: ContactModel.toJson(contact),
      '$baseUrl/${contact.objectId}',
      options: Options(headers: headers),
    );
  }

  @override
  Future<List<ContactModel>> getContacts() async {
      if (await CheckConnection.isConnected == false)throw AppExceptionConnect();
    List<ContactModel> listContacts = [];
    final resultList = await dio.get(
      baseUrl,
      options: Options(headers: headers),
    );
    List list = resultList.data['results'];

    for (var element in list) {
      listContacts.add(ContactModel.formJon(element));
    }

    return listContacts;
  }

  @override
  Future<void> createContact(ContactModel contact) async {
      if (await CheckConnection.isConnected == false)throw AppExceptionConnect();
    dio.post(baseUrl,
        options: Options(headers: headers), data: ContactModel.toJson(contact),);
  }
}
