import 'dart:convert';

import 'package:flutter_tuto/core/utils/typedef.dart';
import 'package:flutter_tuto/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.avatar,
    required super.name,
    required super.createdAt,
    required super.id,
  });

  const UserModel.empty()
      : this(
      id: "1",
      createdAt: '_empty.createdAt',
      name: '_empty.name',
      avatar: '_empty.avatar');

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
            avatar: map['avatar'] as String,
            createdAt: map['createdAt'] as String,
            name: map['name'] as String,
            id: map['id'] as String);

  DataMap toMap() =>
      {'id': id, 'createdAt': createdAt, 'name': name, 'avatar': avatar};

  String toJson() => jsonEncode(toMap());

  UserModel copyWith(
      {String? avatar, String? id, String? name, String? createdAt}) {
    return UserModel(
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id);
  }
}
