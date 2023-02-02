// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      userId: json['userId'] as String,
      msg: json['msg'] as String,
      dt: DateTime.parse(json['dt'] as String),
      from: json['from'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'userId': instance.userId,
      'msg': instance.msg,
      'dt': instance.dt.toIso8601String(),
      'from': instance.from,
    };
