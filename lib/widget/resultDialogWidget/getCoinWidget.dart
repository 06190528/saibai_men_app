import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saibai_men_app/provider.dart';

class GetCoinWidget extends ConsumerWidget {
  double width;
  double height;
  GetCoinWidget({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coinCount = ref.watch(getCoinCountProvider);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/coin.png',
              width: width * 0.3,
              height: height * 0.8,
            ),
            SizedBox(width: width * 0.05),
            Text(
              '×',
              style:
                  TextStyle(fontSize: width * 0.2, fontWeight: FontWeight.bold),
            ),
            Text(
              ' ${coinCount}',
              style: TextStyle(
                fontSize: width * 0.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
