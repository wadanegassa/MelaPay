import 'package:dartz/dartz.dart';
import 'package:melapay/core/errors/failure.dart';
import 'package:melapay/features/wallets/domain/entities/wallet.dart';
import 'package:melapay/features/wallets/domain/repositories/wallet_repository.dart';

class GetWalletsUseCase {
  final WalletRepository repository;
  GetWalletsUseCase(this.repository);

  Future<Either<Failure, List<Wallet>>> execute() {
    return repository.getWallets();
  }
}

class GetWalletUseCase {
  final WalletRepository repository;
  GetWalletUseCase(this.repository);

  Future<Either<Failure, Wallet>> execute(String id) {
    return repository.getWallet(id);
  }
}

class GetTransactionsUseCase {
  final WalletRepository repository;
  GetTransactionsUseCase(this.repository);

  Future<Either<Failure, List<Transaction>>> execute(String walletId) {
    return repository.getTransactions(walletId);
  }
}

class DepositUseCase {
  final WalletRepository repository;
  DepositUseCase(this.repository);

  Future<Either<Failure, void>> execute(String id, double amount) {
    if (amount <= 0) {
      return Future.value(const Left(ValidationFailure('Amount must be greater than zero')));
    }
    return repository.deposit(id, amount);
  }
}

class WithdrawUseCase {
  final WalletRepository repository;
  WithdrawUseCase(this.repository);

  Future<Either<Failure, void>> execute(String id, double amount) {
    if (amount <= 0) {
      return Future.value(const Left(ValidationFailure('Amount must be greater than zero')));
    }
    return repository.withdraw(id, amount);
  }
}

class TransferUseCase {
  final WalletRepository repository;
  TransferUseCase(this.repository);

  Future<Either<Failure, void>> execute(String fromId, String toId, double amount) {
    if (amount <= 0) {
      return Future.value(const Left(ValidationFailure('Amount must be greater than zero')));
    }
    if (fromId == toId) {
      return Future.value(const Left(ValidationFailure('Source and destination wallets must be different')));
    }
    return repository.transfer(fromId, toId, amount);
  }
}
