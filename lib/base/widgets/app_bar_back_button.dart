import 'package:flutter/cupertino.dart';
import 'package:flutternow/app.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
    this.fullscreen = false,
  });

  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    if (fullscreen) {
      return CupertinoButton(
        onPressed: () => Navigator.of(context).maybePop(),
        minSize: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Assets.images.icArrowDown.image(width: 32),
      );
    }
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Assets.images.icNavBack.image(width: 24, height: 24),
      onPressed: () {
        Navigator.of(context).maybePop();
      },
    );
  }
}
