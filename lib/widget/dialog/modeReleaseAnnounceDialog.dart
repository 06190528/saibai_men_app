import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModeReleaseAnnounceDialog extends ConsumerWidget {
  const ModeReleaseAnnounceDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('ハードモードが開放されました！'),
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // ダイアログを閉じる
          },
          child: Text('閉じる'),
        ),
      ],
    );
  }
}
