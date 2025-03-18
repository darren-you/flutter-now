import 'package:flutternow/base/base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_model.freezed.dart';
part 'app_user_model.g.dart';

/// 用户信息
@freezed
class AppUserModel with _$AppUserModel {
  const factory AppUserModel({
    @JsonAlwaysString() @Default('') String id, // ID号
    @Default('') String token, // 登陆Token
    @Default('') String name, // 昵称
    @Default('') String avatar, // 头像URL
  }) = _AppUserModel;

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);
}
