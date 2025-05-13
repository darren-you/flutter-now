import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutternow/base/widgets/app_bar_back_button.dart';
import 'package:flutternow/constants/app_define.dart';
import 'package:flutternow/theme.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MAppBar({
    super.key,
    this.child,
    this.backgroundColor = Colors.transparent,
    this.systemOverlayStyle,
    this.enabledBack = true,
    this.enabledBackdrop = false,
  });

  final Widget? child;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool enabledBack;
  final bool enabledBackdrop;

  @override
  Widget build(BuildContext context) {
    Widget appBar = AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlayStyle ?? kSystemUiOverlayStyle,
      child: Container(
        color: backgroundColor ?? context.appColors.appBar,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: AppDefine.kMyToolBarHeight,
            alignment: Alignment.center,
            child: _buildAppBar(context, child),
          ),
        ),
      ),
    );

    if (enabledBackdrop) {
      appBar = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: appBar,
        ),
      );
    }

    return appBar;
  }

  Widget? _buildAppBar(BuildContext context, Widget? child) {
    final route = ModalRoute.of(context);
    final typeFullScreenDialog = route is PageRoute && route.fullscreenDialog;
    return Stack(
      children: [
        if (enabledBack)
          Align(
            alignment: Alignment.centerLeft,
            child: AppBarBackButton(fullscreen: typeFullScreenDialog),
          ),
        Align(
          alignment: Alignment.center,
          child: child ?? const SizedBox(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDefine.kMyToolBarHeight);
}
