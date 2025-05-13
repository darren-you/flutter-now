import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutternow/base/base.dart';
import 'package:flutternow/base/widgets/line_spacer_widget.dart';
import 'package:flutternow/base/widgets/line_widget.dart';
import 'package:flutternow/managers/protocol_manager.dart';
import 'package:flutternow/modules/fun/ui/fun_menu_item.dart';
import 'package:flutternow/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FunPage extends ConsumerWidget {
  const FunPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MAppBar(
        backgroundColor: Colors.white,
        enabledBack: false,
        enabledBackdrop: false,
      ),
      backgroundColor: Colors.grey.withValues(alpha: 0.4),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: _buildFunMenuList(context).length,
          itemBuilder: (context, index) {
            return _buildFunMenuList(context)[index];
          },
        ),
      ),
    );
  }

  List<Widget> _buildFunMenuList(BuildContext context) {
    return [
      LineWidget(),
      FunMenuItem(
        title: '清除隐私协议状态',
        onClick: () {
          ProtocolManager.instance.removeAgreedAppProtocol();
          BotToast.showText(text: '清除成功✅');
        },
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: '游客登陆',
        onClick: () {},
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: '账号登陆',
        onClick: () {},
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: '验证码登陆',
        onClick: () {
          AccoutLoginRoute().push(context);
        },
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: '微信登陆',
        onClick: () {},
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: 'QQ登陆',
        onClick: () {},
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: '游客登陆',
        onClick: () {},
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: '微信支付',
        onClick: () {},
      ),
      LineSpacerWidget(),
      FunMenuItem(
        title: '支付宝支付',
        onClick: () {},
      ),
      LineWidget(),
    ];
  }
}
