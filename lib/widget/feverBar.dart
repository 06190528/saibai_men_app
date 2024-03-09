import 'package:flutter/material.dart';

class FeverBar extends StatelessWidget {
  final double width; // ゲージの全体の幅
  final double height; // ゲージの高さ
  final double currentEnemyCount; // 現在のHP
  final double feverCount; // 最大HP

  const FeverBar({
    Key? key,
    required this.width,
    required this.height,
    required this.currentEnemyCount,
    required this.feverCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double ratio = currentEnemyCount / feverCount > 1.0
        ? 1.0
        : currentEnemyCount / feverCount;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2), // 角を丸くする
        border: Border.all(color: Colors.black, width: 2.0), // 黒い枠線
        color: Colors.grey[300], // HPが減った時の背景色
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: ratio, // ゲージの割合に応じて幅を設定
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.orange], // グラデーションの色
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 1.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  color: Colors.grey.withOpacity(0.5), // 未到達部分の背景色
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
