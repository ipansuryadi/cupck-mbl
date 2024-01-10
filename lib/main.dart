import 'package:flutter/material.dart';
import 'package:simplest/setup.dart';

import 'my_app.dart';

void main() async {
  runApp(const MyApp());
  await permission();
  await firebaseSetup();
}
