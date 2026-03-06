import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:melapay/core/errors/failure.dart';
import 'package:melapay/features/wallets/data/datasources/wallet_local_datasource.dart';
import 'package:melapay/features/wallets/data/datasources/wallet_remote_datasource.dart';

import 'package:melapay/features/wallets/domain/entities/wallet.dart';
import 'package:melapay/features/wallets/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;
  final WalletLocalDataSource _localDataSource;

  WalletRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<Wallet>>> getWallets() async {
    try {
      // Try remote first
      final models = await _remoteDataSource.getWallets();
      // Cache the result
      await _localDataSource.cacheWallets(models);
      return Right(models.map((m) => Wallet(id: m.id, balance: m.balance)).toList());
    } catch (e) {
      // Fallback to cache
      final cachedModels = await _localDataSource.getWallets();
      if (cachedModels.isNotEmpty) {
        return Right(cachedModels.map((m) => Wallet(id: m.id, balance: m.balance)).toList());
      }
      
      if (e is DioException) {
        return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to load wallets'));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Wallet>> getWallet(String id) async {
    try {
      final model = await _remoteDataSource.getWallet(id);
      return Right(Wallet(id: model.id, balance: model.balance));
    } on DioException catch (e) {
      // For single wallet, we might still have it in the cached list
      final cachedWallets = await _localDataSource.getWallets();
      final cached = cachedWallets.where((w) => w.id == id).firstOrNull;
      if (cached != null) {
        return Right(Wallet(id: cached.id, balance: cached.balance));
      }
      return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to load wallet'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(String walletId) async {
    try {
      final models = await _remoteDataSource.getTransactions(walletId);
      await _localDataSource.cacheTransactions(walletId, models);
      return Right(models.map((m) => Transaction(
        id: m.id,
        walletId: m.walletId,
        type: TransactionType.values.byName(m.type),
        amount: m.amount,
        timestamp: DateTime.parse(m.timestamp),
        description: m.description,
      )).toList());
    } catch (e) {
      final cachedModels = await _localDataSource.getTransactions(walletId);
      if (cachedModels.isNotEmpty) {
        return Right(cachedModels.map((m) => Transaction(
          id: m.id,
          walletId: m.walletId,
          type: TransactionType.values.byName(m.type),
          amount: m.amount,
          timestamp: DateTime.parse(m.timestamp),
          description: m.description,
        )).toList());
      }
      
      if (e is DioException) {
        return Left(ServerFailure(e.response?.data?['error'] ?? 'Failed to load transactions'));
      }
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
