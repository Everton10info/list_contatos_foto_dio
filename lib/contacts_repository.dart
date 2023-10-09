import 'package:list_contatos_foto_dio/contacts_model.dart';
import 'package:dio/dio.dart';

abstract interface class ContactRepopsitory {
  Future<void> createContact(ContactModel contact);
  Future<List<ContactModel>> getContacts();
  deleteContacts(String id);
  Future<ContactModel> editContact(ContactModel contact);
}

class RepositoryImpl implements ContactRepopsitory {
  final String baseUrl = 'https://parseapi.back4app.com/classes/contacts';
  final headers = {
    'X-Parse-Application-Id': '98mIVWi5wNZ5ZS0khB8W2xkMTicUP8YSpT3Z0ARo',
    'X-Parse-REST-API-Key': '999OoVwkJueHKI0UHd7OvYkGsAhDN7D4zLXfysPn',
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
  editContact(ContactModel contact) {
    // TODO: implement editContact
    throw UnimplementedError();
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
