import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int messageId;
  final String forUserGuid;
  final String userGuid;
  final String message;
  final DateTime createdOn;
  final String userFirstName;
  final String? userLastName;
  final String userType;
  final String? userProfile;

  const Message({
    required this.messageId,
    required this.forUserGuid,
    required this.userGuid,
    required this.message,
    required this.createdOn,
    required this.userFirstName,
    required this.userLastName,
    required this.userType,
    required this.userProfile,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
