import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/base/widgets/app_bar.dart';
import 'package:flutternow/base/widgets/custom_container.dart';
import 'package:flutternow/network/api_client.dart';
import 'package:flutternow/providers/app_user_provider.dart';
import 'package:flutternow/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountLoginPage extends HookConsumerWidget {
  const AccountLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final passController = useTextEditingController();
    final loginResult = useState('');
    final userProfile = useState('');

    return Scaffold(
      appBar: MAppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        // color: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // 账号登录
            // const Padding(padding: EdgeInsets.only(top: 64)),
            // Text('账号'),
            // const Padding(padding: EdgeInsets.only(bottom: 4)),
            // CupertinoTextField(
            //   controller: nameController,
            //   style: TextStyle(color: context.appColors.textMain),
            // ),
            // const Padding(padding: EdgeInsets.only(top: 16)),
            // Text('密码'),
            // const Padding(padding: EdgeInsets.only(bottom: 4)),
            // CupertinoTextField(
            //   controller: passController,
            //   style: TextStyle(color: context.appColors.textMain),
            // ),
            // const Padding(padding: EdgeInsets.only(bottom: 32)),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: CustomContainer(
            //     borderRadius: BorderRadius.circular(50),
            //     duration: Duration(milliseconds: 160),
            //     scaleValue: 0.99,
            //     onTap: () async {
            //       try {
            //         accountLogin(context, ref, nameController.text,
            //             passController.text, loginResult);
            //       } on DioException catch (e) {
            //         loginResult.value = 'msg: ${e.message}';
            //       }
            //     },
            //     child: Container(
            //       width: 100,
            //       height: 40,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         color: Colors.blue,
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       child: Text(
            //         '登录',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),

            // 验证码登录
            const Padding(padding: EdgeInsets.only(top: 64)),
            Text('手机号'),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CupertinoTextField(
              controller: nameController,
              style: TextStyle(color: context.appColors.textMain),
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomContainer(
                borderRadius: BorderRadius.circular(50),
                duration: Duration(milliseconds: 160),
                scaleValue: 0.99,
                onTap: () async {
                  _getSmsCode(nameController.text, loginResult);
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '发送验证码',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            Text('验证码'),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CupertinoTextField(
              controller: passController,
              style: TextStyle(color: context.appColors.textMain),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 32)),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomContainer(
                borderRadius: BorderRadius.circular(50),
                duration: Duration(milliseconds: 160),
                scaleValue: 0.99,
                onTap: () async {
                  _smsCodeLogin(ref, nameController.text, passController.text,
                      loginResult);
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '登录',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const Padding(padding: EdgeInsets.only(bottom: 16)),
            ValueListenableBuilder(
              valueListenable: loginResult,
              builder: (context, value, child) {
                return Text(value);
              },
            ),

            // 获取用户信息
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            ValueListenableBuilder(
              valueListenable: userProfile,
              builder: (context, value, child) {
                return Text(
                  value,
                  style: TextStyle(color: Colors.grey),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 账号密码登录
  void _accountLogin(BuildContext context, WidgetRef ref, String username,
      String password, ValueNotifier<String> loginResult) async {
    if (username.isEmpty) {
      BotToast.showText(text: '请输入账号');
      return;
    }
    if (password.isEmpty) {
      BotToast.showText(text: '请输入密码');
      return;
    }
    try {
      BotToast.showLoading();
      final appUserModel = (await getIt<ApiClient>()
              .loginByAccount(username: username, password: password))
          .data!;
      loginResult.value = appUserModel.toJson().toString();
      BotToast.showText(text: '欢迎👋: ${appUserModel.username}');
      ref.read(appUserProvider.notifier).save(appUserModel);
      BotToast.closeAllLoading();
    } on DioException catch (e) {
      loginResult.value = e.message ?? '';
      BotToast.closeAllLoading();
      BotToast.showText(text: '${e.message}');
      log('登录错误: ${e.message} time: ${DateTime.now()}', name: 'login');
    }
  }

  // 获取短信验证码
  Future<void> _getSmsCode(
      String phone, ValueNotifier<String> loginResult) async {
    loginResult.value = '';
    if (phone.isEmpty) {
      BotToast.showText(text: '请输入手机号');
      return;
    }
    try {
      BotToast.showLoading();
      await getIt<ApiClient>().getSMSCode(phone: phone);
      BotToast.showText(text: '已发送验证码');
    } on DioException catch (e) {
      loginResult.value = e.message ?? '';
      log('获取验证码错误: ${e.message} time: ${DateTime.now()}', name: 'login');
    } finally {
      BotToast.closeAllLoading();
    }
  }

  // 短信验证码登录
  Future<void> _smsCodeLogin(WidgetRef ref, String phone, String smsCode,
      ValueNotifier<String> loginResult) async {
    loginResult.value = '';
    if (phone.isEmpty) {
      BotToast.showText(text: '请输入手机号');
      return;
    }
    if (smsCode.isEmpty) {
      BotToast.showText(text: '请输入验证码');
      return;
    }
    try {
      BotToast.showLoading();
      // 登陆
      final appUserModel = (await getIt<ApiClient>()
              .loginByPhone(phone: phone, captcha: smsCode))
          .data!;
      ref.read(appUserProvider.notifier).save(appUserModel);
      // 刷新用户信息
      await ref.read(appUserProvider.notifier).refresh();
      final localAppUserModel = ref.read(appUserProvider);
      loginResult.value = localAppUserModel!.toJson().toString();
      BotToast.showText(text: '欢迎👋: ${localAppUserModel.username}');
    } on DioException catch (e) {
      loginResult.value = e.message ?? '';
      log('登录错误: ${e.message} time: ${DateTime.now()}', name: 'login');
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
