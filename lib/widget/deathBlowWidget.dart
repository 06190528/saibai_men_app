import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/provider.dart';

class DeathBlowWidget extends ConsumerWidget {
  final Function() onActivateSpecialMove;
  const DeathBlowWidget({required this.onActivateSpecialMove, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () async {
          // ボタンがタップされたときの処理
          await onActivateSpecialMove();
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/energy icon.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover, // 画像をボックスにフィットさせる
            ),
            Text(
              ref.watch(deathblowCountProvider).toString(),
              style: TextStyle(fontSize: 20, color: Colors.black),
            )
          ],
        ));
  }
}
