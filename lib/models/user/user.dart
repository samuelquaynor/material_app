library user;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:material_app/models/serializers/serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  // fields go here

  String get id;

  String? get email;

  String? get name;

  String? get photo;

  User._();

  factory User([Function(UserBuilder b) updates]) = _$User;

  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User? fromJson(String jsonString) {
    return serializers.deserializeWith(
        User.serializer, json.decode(jsonString));
  }

  static Serializer<User> get serializer => _$userSerializer;
}
