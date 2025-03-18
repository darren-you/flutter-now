import 'package:flutter/material.dart';
import 'package:flutternow/base/base.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MinePage extends ConsumerWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MAppBar(
        title: 'MinePage',
      ),
      body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}
