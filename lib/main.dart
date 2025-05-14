import 'package:flutter/material.dart';
import 'package:santa_brasa/app_widget.dart';
import 'package:santa_brasa/config/depedency.dart';

void main() async {
  setupInjection();
  runApp(const MyApp());
}
