import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Unknwon Screen is called');
    return Scaffold(
      appBar: AppBar(),
      body: Text('UnknownScreen'),
    );
  }
}
