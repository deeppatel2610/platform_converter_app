// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Temp extends StatelessWidget {
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("deep")),
      child: Center(child: Text("deep")),
    );
  }
}
