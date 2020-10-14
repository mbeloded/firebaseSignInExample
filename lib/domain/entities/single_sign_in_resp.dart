
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';

part 'single_sign_in_resp.g.dart';

///flutter pub run build_runner build
@JsonSerializable(explicitToJson:true)
class SingleSignInDto extends Equatable {
  final String token;
  final UserEntity profileInfo;

  SingleSignInDto([this.token, this.profileInfo]);

  @override
  List<Object> get props => [
  token, profileInfo
  ];

  factory SingleSignInDto.fromJson(Map<String, dynamic> json) =>
      _$SingleSignInDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SingleSignInDtoToJson(this);
}