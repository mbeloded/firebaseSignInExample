// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_sign_in_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleSignInDto _$SingleSignInDtoFromJson(Map<String, dynamic> json) {
  return SingleSignInDto(
      json['token'] as String,
      json['profileInfo'] == null
          ? null
          : UserEntity.fromJson(json['profileInfo'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SingleSignInDtoToJson(SingleSignInDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'profileInfo': instance.profileInfo?.toJson()
    };
