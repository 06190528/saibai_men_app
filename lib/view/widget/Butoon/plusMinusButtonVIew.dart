import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush_time_app/provider/time_provider.dart';

class PlusMinusButton extends StatelessWidget {
  final bool isPlus;
  const PlusMinusButton({super.key, required this.isPlus});

  @override
  Widget build(BuildContext context) {
    final setTime = Provider.of<SetTime>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.1,
      child: FloatingActionButton(
        onPressed: () {
          // ボタンが押されたときの処理
          if (isPlus) {
            setTime.add1min();
          } else {
            setTime.minus1min();
          }
        }, // 三項演算子を使用
        backgroundColor: const Color.fromARGB(185, 254, 165, 0),
        child: isPlus ? const Icon(Icons.add) : const Icon(Icons.remove),
      ),
    );
  }
}
