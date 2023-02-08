import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String fcmToken;
  final String userProfile;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.fcmToken,
    required this.userProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
