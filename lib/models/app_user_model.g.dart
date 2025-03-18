// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserModelImpl _$$AppUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AppUserModelImpl(
      id: json['id'] == null
          ? ''
          : const JsonAlwaysString().fromJson(json['id']),
      token: json['token'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
    );

Map<String, dynamic> _$$AppUserModelImplToJson(_$AppUserModelImpl instance) =>
    <String, dynamic>{
      'id': const JsonAlwaysString().toJson(instance.id),
      'token': instance.token,
      'name': instance.name,
      'avatar': instance.avatar,
    };
