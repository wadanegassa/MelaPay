import 'package:dartz/dartz.dart';
import 'package:melapay/core/errors/failure.dart';
import 'package:melapay/features/wallets/domain/entities/wallet.dart';

abstract class WalletRepository {
  Future<Either<Failure, List<Wallet>>> getWallets();
  Future<Either<Failure, Wallet>> getWallet(String id);
  Future<Either<Failure, List<Transaction>>> getTransactions(String walletId);
  Future<Either<Failure, void>> deposit(String id, double amount);
  Future<Either<Failure, void>> withdraw(String id, double amount);
  Future<Either<Failure, void>> transfer(String fromId, String toId, double amount);
}
