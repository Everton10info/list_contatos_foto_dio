// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactModel {
  String? objectId;
  String picture;
  String name;
  ContactModel({
    this.objectId,
    required this.picture,
    required this.name,
  });

  static ContactModel formJon(Map<String, dynamic> json) {
    return ContactModel(
      objectId: json['objectId'],
      picture: json['picture'],
      name: json['name'],
    );
  }

  static Map<String, dynamic> toJson(ContactModel contact) {
    return {
      'objectId': contact.objectId ?? '',
      'picture': contact.picture,
      'name': contact.name,
    };
  }
}
