import 'package:flutter/material.dart';

import 'core/loaclization/intialize_localization.dart';
import 'perla_task_main_widget_app.dart';

import 'dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await IntializeLocalization.initial();
  runApp(PerlaTaskMainWidgetApp());
}
