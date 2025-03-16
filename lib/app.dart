import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_system_proxy/flutter_system_proxy.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutternow/managers/user_defaults.dart';
import 'package:flutternow/models/app_info_model.dart';
import 'package:uuid/uuid.dart';

export 'generated/assets.gen.dart';

final _logName = 'app.dart';

/// get_it 依赖注入框架初始化
final getIt = GetIt.instance;
bool isFontWeigthSupportW500 = false;

/// 初始化基础框架
///
/// 1、Flutter从屏幕编译开始绘制
/// 2、SharePreference初始化
/// 3、网络代理初始化
/// 4、EventBus单例依赖注入
/// 5、字重支持判断初始化
Future<void> initBase() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await UserDefaults.instance.init();
  HttpOverrides.global = await HttpProxyOverride.createHttpProxy();
  getIt.registerSingleton<EventBus>(EventBus());
  FontWeightExt.getFontWeigthSupport();
  log('initBase✅ 初始化基础框架完成', name: _logName);
}

/// 初始化App框架，同意协议后
///
/// 1、获取包信息
/// 2、设备信息
/// 3、Dio初始化
/// 4、各类管理Manager初始化
/// 5、三方SDK初始化
Future<AppInfoModel> initApp() async {
  String deviceId = '', deviceModel = '', systemVersion = '';
  final packageInfo = await PackageInfo.fromPlatform();
  final deviceInfo = await DeviceInfoPlugin().deviceInfo;

  if (deviceInfo is AndroidDeviceInfo) {
    String? id = await AndroidId().getId();
    if (id == null || id.isEmpty) {
      // 获取不到android id，生成一个存在本地
      final localDeviceId = UserDefaults.instance.getString('deviceId') ?? '';
      if (localDeviceId.isEmpty) {
        id = const Uuid().v1();
        UserDefaults.instance.setString('deviceId', id);
      } else {
        id = localDeviceId;
      }
    }
    deviceId = id;
    deviceModel = deviceInfo.model;
  } else if (deviceInfo is IosDeviceInfo) {
    deviceId = deviceInfo.identifierForVendor ?? '';
    deviceModel = deviceInfo.utsname.machine;
    systemVersion = deviceInfo.systemVersion;
  }

  final appInfo = AppInfoModel(
    packageName: packageInfo.packageName,
    version: packageInfo.version,
    deviceId: deviceId,
    deviceModel: deviceModel,
    systemVersion: systemVersion,
    firstLaunch: false,
  );

  return appInfo;
}

/// 字重支持判断扩展
extension FontWeightExt on FontWeight {
  static get medium {
    return isFontWeigthSupportW500 ? FontWeight.w500 : FontWeight.bold;
  }

  static get bold {
    return FontWeight.bold;
  }

  /// 字重支持判断初始化
  static void getFontWeigthSupport() async {
    if (Platform.isIOS) {
      isFontWeigthSupportW500 = true;
    } else if (Platform.isAndroid) {
      try {
        final w400 = await _getImage(const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w400, color: Colors.red));
        final w500 = await _getImage(const TextStyle(
            fontSize: 10, fontWeight: FontWeight.w500, color: Colors.red));
        isFontWeigthSupportW500 = !listEquals(w400, w500);
        log('字重支持判断完毕，Medium = $isFontWeigthSupportW500', name: 'Debug');
      } catch (e) {
        log('字重支持判断出错：$e', name: 'Debug');
      }
    }
  }

  // 使用Painter使用不同字重绘制图片，转换为byte比较
  static Future<Uint8List?> _getImage(TextStyle style) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '一',
        style: style,
      ),
      maxLines: 1,
    )..layout();
    painter.paint(canvas, Offset.zero);
    final picture = recorder.endRecording();
    final image = picture.toImageSync(10, 10);
    final bytes = await image.toByteData();
    return bytes?.buffer.asUint8List();
  }
}
