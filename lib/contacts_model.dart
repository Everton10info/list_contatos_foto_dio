// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactModel {
  String picture;
  String name;
  ContactModel({
    required this.picture,
    required this.name,
  });

  static ContactModel formJon(Map<String, dynamic> json) {
    return ContactModel(
      picture: json['picture'],
      name: json['name'],
    );
  }

  static Map<String, dynamic> toJson(ContactModel contact) {
    return {
      'picture': contact.picture,
      'name': contact.name,
    };
  }
}
