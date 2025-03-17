import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_info_model.freezed.dart';
part 'app_info_model.g.dart';

@freezed
class AppInfoModel with _$AppInfoModel {
  const factory AppInfoModel({
    @Default('') String packageName,
    @Default('') String appVersion,
    @Default('') String deviceId,
    @Default('') String deviceModel,
    @Default('') String systemVersion,
    @Default(false) bool firstLaunch,
  }) = _AppInfoModel;

  factory AppInfoModel.fromJson(Map<String, Object?> json) =>
      _$AppInfoModelFromJson(json);
}
