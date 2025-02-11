import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../dependency_manager.dart';
import '../../domain/entity/task_entity.dart';

class Application {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Future.wait([
      Firebase.initializeApp(),
      Hive.initFlutter(),
    ]);

    Hive.registerAdapter(TaskEntityAdapter());
    DependencyManager.initialize();
  }
}
