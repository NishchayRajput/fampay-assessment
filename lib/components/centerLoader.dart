import 'package:flutter/material.dart';
class CenteredLoader extends StatelessWidget {
const CenteredLoader();
@override
Widget build(BuildContext context) {
  return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()));
}
}
