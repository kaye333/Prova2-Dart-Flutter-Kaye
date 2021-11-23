// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TitleBanner extends StatelessWidget {
  const TitleBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(text: 'Prova', children: [
        TextSpan(
          text: ' Flutter ',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        TextSpan(
          text: '02 - Login',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ]),
    );
  }
}
