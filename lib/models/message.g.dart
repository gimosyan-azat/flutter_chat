// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      forUserGuid: json['forUserGuid'] as String,
      userGuid: json['userGuid'] as String,
      messageId: json['messageId'] as int,
      message: json['message'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
      userFirstName: json['userFirstName'] as String,
      userLastName: json['userLastName'] as String,
      userType: json['userType'] as String,
      userProfile: json['userProfile'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'forUserGuid': instance.forUserGuid,
      'userGuid': instance.userGuid,
      'messageId': instance.messageId,
      'message': instance.message,
      'createdOn': instance.createdOn.toIso8601String(),
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'userType': instance.userType,
      'userProfile': instance.userProfile,
    };
