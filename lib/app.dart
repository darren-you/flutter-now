import 'dart:developer';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_system_proxy/flutter_system_proxy.dart';
import 'package:flutternow/extensions/fontweight_ext.dart';
import 'package:flutternow/managers/app_info_manager.dart';
import 'package:flutternow/managers/local_storage_manager.dart';
import 'package:get_it/get_it.dart';

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
  await LocalStorageManager.instance.init();
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
Future<void> initApp() async {
  await AppInfoManager.instance.init();
  AppInfoManager.instance.appInfoModel;
}
