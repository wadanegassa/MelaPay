import 'package:melapay/features/wallets/data/models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<List<WalletModel>> getWallets();
  Future<WalletModel> getWallet(String id);
  Future<List<TransactionModel>> getTransactions(String walletId);
  Future<void> deposit(String id, double amount);
  Future<void> withdraw(String id, double amount);
  Future<void> transfer(String fromId, String toId, double amount);
}
