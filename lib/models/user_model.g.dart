// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      name: json['user']['name'] as String,
      profilePic: json['user']['profilePic'] as String,
      email: json['user']['email'] as String,
      uid: json['user']['_id'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'name': instance.name,
      'profilePic': instance.profilePic,
      'email': instance.email,
      'uid': instance.uid,
      'token': instance.token,
    };
