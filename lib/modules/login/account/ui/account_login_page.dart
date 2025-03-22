import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutternow/app.dart';
import 'package:flutternow/base/base.dart';
import 'package:flutternow/network/api_client.dart';
import 'package:flutternow/providers/app_user_provider.dart';
import 'package:flutternow/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountLoginPage extends ConsumerWidget {
  const AccountLoginPage({super.key});

  void login(BuildContext context, WidgetRef ref, String username,
      String password) async {
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
      BotToast.showText(text: '欢迎👋: ${appUserModel.username}');
      ref.read(appUserProvider.notifier).save(appUserModel);
      BotToast.closeAllLoading();
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: '${e.message}');
      log('登录错误: ${e.message} time: ${DateTime.now()}', name: 'login');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      appBar: MAppBar(
        title: '账号登录',
      ),
      body: Container(
        // color: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 64)),
            Text('账号'),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CupertinoTextField(
              controller: nameController,
              style: TextStyle(color: context.appColors.text1),
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            Text('密码'),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CupertinoTextField(
              controller: passController,
              style: TextStyle(color: context.appColors.text1),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 32)),
            Align(
              alignment: Alignment.center,
              child: CustomContainer(
                borderRadius: BorderRadius.circular(50),
                duration: Duration(milliseconds: 160),
                scaleValue: 0.99,
                onTap: () => login(
                    context, ref, nameController.text, passController.text),
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Assets.svg.iconRight,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
