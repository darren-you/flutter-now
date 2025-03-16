import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutternow/base/base.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MAppBar(
        backgroundColor: Colors.transparent,
        enabledBackdrop: false,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Text('First page'),
        ),
      ),
    );
  }
}
