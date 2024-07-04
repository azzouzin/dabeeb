import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClientModel {
  int id;
  String name;
  String phone;
  String address;
  String email;
  ClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
