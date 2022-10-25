// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentModel _$$_DocumentModelFromJson(Map<String, dynamic> json) =>
    _$_DocumentModel(
      title: json['title'] as String,
      uid: json['uid'] as String,
      content: json['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      id: json['id'] as String,
    );

Map<String, dynamic> _$$_DocumentModelToJson(_$_DocumentModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'uid': instance.uid,
      'content': instance.content,
      'createdAt': instance.createdAt.millisecondsSinceEpoch,
      'id': instance.id,
    };
