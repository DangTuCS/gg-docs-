// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      name: json['name'] as String,
      profilePic: json['profilePic'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'name': instance.name,
      'profilePic': instance.profilePic,
      'email': instance.email,
      'uid': instance.uid,
      'token': instance.token,
    };
