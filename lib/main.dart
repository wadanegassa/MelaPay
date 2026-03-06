import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melapay/app/app.dart';
import 'package:melapay/core/persistence/persistence_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final persistenceService = PersistenceService();
  await persistenceService.init();
  
  runApp(
    ProviderScope(
      overrides: [
        persistenceServiceProvider.overrideWithValue(persistenceService),
      ],
      child: const MelaPayApp(),
    ),
  );
}
