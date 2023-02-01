import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String userId;
  final String msg;
  //final DateTime dt;
  final String from;

  const Message(
      {required this.userId,
      required this.msg,
      //required this.dt,
      required this.from});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
