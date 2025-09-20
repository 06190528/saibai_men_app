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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 3), // 影の位置を調整
          ),
        ],
        gradient: LinearGradient(
          colors: [Colors.red, Colors.orangeAccent], // グラデーションの色
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15), // 角の丸み
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15), // インクエフェクトのための丸み
          onTap: () async {
            // ボタンがタップされたときの処理
            await onActivateSpecialMove();
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center, // 子要素を中央に配置
              children: <Widget>[
                Image.asset(
                  'assets/images/energy icon.png',
                  width: width * 0.08,
                  height: width * 0.08,
                  fit: BoxFit.cover, // 画像をボックスにフィットさせる
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      ref.watch(deathblowCountProvider).toString(),
                      style: TextStyle(
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
