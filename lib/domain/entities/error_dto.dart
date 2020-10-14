import 'package:json_annotation/json_annotation.dart';

part 'error_dto.g.dart';

///flutter pub run build_runner build
@JsonSerializable(explicitToJson:true)
class ErrorEntity {
  //public
  int code;
  String message;
  String description;

  ErrorEntity(
      this.code, [this.message, this.description]);

  @override
  List<Object> get props => [code, message, description];

  factory ErrorEntity.fromJson(Map<String, dynamic> json) => _$ErrorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorEntityToJson(this);
}