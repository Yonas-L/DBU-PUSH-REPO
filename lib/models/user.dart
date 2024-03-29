import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? uId;
  final String? role;
  final String? channelId;
  final String avatar;
  final String? bio;
  final bool? isActive;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.uId,
    this.role,
    this.channelId,
    required this.avatar,
    this.bio,
    this.isActive,
  });
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
        id: doc.get('id'),
        fullName: doc.get('fullName'),
        email: doc.get('email'),
        phone: doc.get('phone'),
        uId: doc.get('uId'),
        role: doc.get('role'),
        channelId: doc.get('channelId'),
        avatar: doc.get('avatar'),
        bio: doc.get('bio'),
        isActive: doc.get('isActive'));
  }
}
