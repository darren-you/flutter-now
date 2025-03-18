import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutternow/base/base.dart';
import 'package:flutternow/managers/protocol_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExamplePage extends ConsumerWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQueryData = MediaQuery.of(context);
    var statusBarHeight = mediaQueryData.padding.top;
    var tabBarHeight = mediaQueryData.padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MAppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.6),
        title: 'ExamplePage',
        enabledBackdrop: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: statusBarHeight + 68),
              ),
              CustomContainer(
                onTap: () {
                  ProtocolManager.instance.removeAgreedAppProtocol();
                  BotToast.showText(text: '清除成功');
                },
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                duration: Duration(milliseconds: 160),
                child: Container(
                  width: 160,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '清除同意App协议',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
