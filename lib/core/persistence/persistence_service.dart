import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'persistence_service.g.dart';

@Riverpod(keepAlive: true)
PersistenceService persistenceService(Ref ref) {
  throw UnimplementedError('Initialize this provider in main.dart');
}

class PersistenceService {
  Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Open boxes for caching
    await Hive.openBox('wallets');
    await Hive.openBox('transactions');
  }

  // Hive Box Accessors
  Box get walletsBox => Hive.box('wallets');
  Box get transactionsBox => Hive.box('transactions');

  Future<void> clearCache() async {
    await walletsBox.clear();
    await transactionsBox.clear();
  }
}
