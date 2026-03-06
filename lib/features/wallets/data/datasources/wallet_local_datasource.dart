import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:melapay/features/wallets/data/models/wallet_model.dart';

abstract class WalletLocalDataSource {
  Future<List<WalletModel>> getWallets();
  Future<void> cacheWallets(List<WalletModel> wallets);
  Future<List<TransactionModel>> getTransactions(String walletId);
  Future<void> cacheTransactions(String walletId, List<TransactionModel> transactions);
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  final Box _walletsBox;
  final Box _transactionsBox;

  WalletLocalDataSourceImpl(this._walletsBox, this._transactionsBox);

  @override
  Future<List<WalletModel>> getWallets() async {
    final data = _walletsBox.get('all_wallets');
    if (data == null) return [];
    return (jsonDecode(data) as List)
        .map((e) => WalletModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> cacheWallets(List<WalletModel> wallets) async {
    await _walletsBox.put('all_wallets', jsonEncode(wallets.map((e) => e.toJson()).toList()));
  }

  @override
  Future<List<TransactionModel>> getTransactions(String walletId) async {
    final data = _transactionsBox.get(walletId);
    if (data == null) return [];
    return (jsonDecode(data) as List)
        .map((e) => TransactionModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> cacheTransactions(String walletId, List<TransactionModel> transactions) async {
    await _transactionsBox.put(walletId, jsonEncode(transactions.map((e) => e.toJson()).toList()));
  }
}
