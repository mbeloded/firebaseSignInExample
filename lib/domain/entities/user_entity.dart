import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

///flutter pub run build_runner build

@JsonSerializable(explicitToJson: true)
class UserEntity extends Equatable {
  final String userId;
  final String name;
  final String email;
  int dob;

  UserEntity(this.userId,
  [
    this.name,
    this.email,
    this.dob
  ]
  );

  @override
  List<Object> get props => [
    userId,
    name,
    email,
    dob
  ];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

}