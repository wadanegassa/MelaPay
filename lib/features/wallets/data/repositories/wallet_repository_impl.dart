import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:melapay/core/errors/failure.dart';
import 'package:melapay/features/wallets/data/datasources/wallet_remote_datasource.dart';

import 'package:melapay/features/wallets/domain/entities/wallet.dart';
import 'package:melapay/features/wallets/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;

  WalletRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Wallet>>> getWallets() async {
    try {
      final models = await _remoteDataSource.getWallets();
      return Right(models.map((m) => Wallet(id: m.id, balance: m.balance)).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to load wallets'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Wallet>> getWallet(String id) async {
    try {
      final model = await _remoteDataSource.getWallet(id);
      return Right(Wallet(id: model.id, balance: model.balance));
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to load wallet'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(String walletId) async {
    try {
      final models = await _remoteDataSource.getTransactions(walletId);
      return Right(models.map((m) => Transaction(
        id: m.id,
        walletId: m.walletId,
        type: TransactionType.values.byName(m.type),
        amount: m.amount,
        timestamp: DateTime.parse(m.timestamp),
        description: m.description,
      )).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to load transactions'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deposit(String id, double amount) async {
    try {
      await _remoteDataSource.deposit(id, amount);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to deposit'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> withdraw(String id, double amount) async {
    try {
      await _remoteDataSource.withdraw(id, amount);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to withdraw'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> transfer(String fromId, String toId, double amount) async {
    try {
      await _remoteDataSource.transfer(fromId, toId, amount);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to transfer'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
