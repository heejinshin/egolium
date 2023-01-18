import 'package:flutter/material.dart';

class PfpCards extends StatelessWidget {
  const PfpCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient:  LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[200]!, Colors.pink[300]!],
        ),
      ),
    );
  }
}
