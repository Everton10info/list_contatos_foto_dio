import 'package:list_contatos_foto_dio/models/contacts_model.dart';
import 'package:dio/dio.dart';
import 'package:list_contatos_foto_dio/shared/config/configs.dart';

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
    await dio.delete(
      '$baseUrl/$id',
      options: Options(headers: headers),
    );
  }

  @override
  editContact(ContactModel contact) async {
    await dio.put(
      data: ContactModel.toJson(contact),
      '$baseUrl/${contact.objectId}',
      options: Options(headers: headers),
    );
  }

  @override
  Future<List<ContactModel>> getContacts() async {
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
    dio.post(baseUrl,
        options: Options(headers: headers), data: ContactModel.toJson(contact));
  }
}
