// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserModelImpl _$$AppUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AppUserModelImpl(
      username: json['username'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      userType: json['user_type'] as String? ?? '',
    );

Map<String, dynamic> _$$AppUserModelImplToJson(_$AppUserModelImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'user_type': instance.userType,
    };
