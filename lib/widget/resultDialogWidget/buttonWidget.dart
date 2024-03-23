import 'package:flutter/material.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleIcon.dart';
import 'package:saibai_men_app/widget/resultDialogWidget/doubleText.dart';

class BannerButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final IconData? icon;

  const BannerButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // 実際に使用する幅を計算
    final actualWidth =
        width ?? MediaQuery.of(context).size.width / 2; // widthがnullならデバイス幅を使用
    final actualHeight = actualWidth / 4; // 縦横比に基づいて高さを計算
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      width: actualWidth,
      height: actualHeight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 212, 82), // ボタンの背景色
        borderRadius: BorderRadius.circular(10), // 角丸設定
        border: Border.all(
          color: Colors.black, // 枠線の色
          width: actualHeight * 0.05, // 枠線の太さ
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.transparent,
          elevation: 0, // 影をなくす
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(0),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...[
              DoubleIcon(
                iconData: icon!,
                size: actualHeight * 0.5,
                insideColor: Colors.white,
              ),
              SizedBox(width: actualWidth * 0.05), // アイコンとテキストの間隔
            ],
            FittedBox(
              fit: BoxFit.scaleDown, // 子が小さい場合はそのまま、大きい場合は縮小
              child: DoubleText(
                text: text,
                fontSize: actualHeight * 0.35, // 基本サイズ
                insideColor: Colors.white,
              ),
            ),
            // Text(
            //   'Custom Font Text',
            //   style: TextStyle(
            //     fontFamily: 'CustomFont',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
