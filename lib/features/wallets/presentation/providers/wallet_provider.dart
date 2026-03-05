import 'package:dio/dio.dart';
import 'package:melapay/core/network/api_client.dart';
import 'package:melapay/core/network/mock_interceptor.dart';
import 'package:melapay/features/wallets/data/datasources/wallet_remote_datasource_impl.dart';
import 'package:melapay/features/wallets/data/repositories/wallet_repository_impl.dart';
import 'package:melapay/features/wallets/domain/entities/wallet.dart';
import 'package:melapay/features/wallets/domain/repositories/wallet_repository.dart';
import 'package:melapay/features/wallets/domain/usecases/wallet_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'wallet_provider.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = Dio();
  dio.interceptors.add(MockInterceptor());
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  return ApiClient(dio);
}

@riverpod
WalletRepository walletRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final remoteDataSource = WalletRemoteDataSourceImpl(apiClient);
  return WalletRepositoryImpl(remoteDataSource);
}

@riverpod
GetWalletsUseCase getWalletsUseCase(Ref ref) {
  return GetWalletsUseCase(ref.watch(walletRepositoryProvider));
}

@riverpod
GetWalletUseCase getWalletUseCase(Ref ref) {
  return GetWalletUseCase(ref.watch(walletRepositoryProvider));
}

@riverpod
GetTransactionsUseCase getTransactionsUseCase(Ref ref) {
  return GetTransactionsUseCase(ref.watch(walletRepositoryProvider));
}

@riverpod
DepositUseCase depositUseCase(Ref ref) {
  return DepositUseCase(ref.watch(walletRepositoryProvider));
}

@riverpod
WithdrawUseCase withdrawUseCase(Ref ref) {
  return WithdrawUseCase(ref.watch(walletRepositoryProvider));
}

@riverpod
TransferUseCase transferUseCase(Ref ref) {
  return TransferUseCase(ref.watch(walletRepositoryProvider));
}

@riverpod
Future<List<Wallet>> wallets(Ref ref) async {
  final useCase = ref.watch(getWalletsUseCaseProvider);
  final result = await useCase.execute();
  return result.fold(
    (failure) => throw failure.message,
    (wallets) => wallets,
  );
}

@riverpod
Future<Wallet> walletDetails(Ref ref, String id) async {
  final useCase = ref.watch(getWalletUseCaseProvider);
  final result = await useCase.execute(id);
  return result.fold(
    (failure) => throw failure.message,
    (wallet) => wallet,
  );
}

@riverpod
Future<List<Transaction>> transactions(Ref ref, String walletId) async {
  final useCase = ref.watch(getTransactionsUseCaseProvider);
  final result = await useCase.execute(walletId);
  return result.fold(
    (failure) => throw failure.message,
    (transactions) => transactions,
  );
}

@riverpod
class WalletAction extends _$WalletAction {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> deposit(String id, double amount) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(depositUseCaseProvider);
    final result = await useCase.execute(id, amount);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (_) {
        ref.invalidate(walletsProvider);
        ref.invalidate(walletDetailsProvider(id));
        ref.invalidate(transactionsProvider(id));
        return const AsyncValue.data(null);
      },
    );
  }

  Future<void> withdraw(String id, double amount) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(withdrawUseCaseProvider);
    final result = await useCase.execute(id, amount);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (_) {
        ref.invalidate(walletsProvider);
        ref.invalidate(walletDetailsProvider(id));
        ref.invalidate(transactionsProvider(id));
        return const AsyncValue.data(null);
      },
    );
  }

  Future<void> transfer(String fromId, String toId, double amount) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(transferUseCaseProvider);
    final result = await useCase.execute(fromId, toId, amount);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (_) {
        ref.invalidate(walletsProvider);
        ref.invalidate(walletDetailsProvider(fromId));
        ref.invalidate(walletDetailsProvider(toId));
        ref.invalidate(transactionsProvider(fromId));
        ref.invalidate(transactionsProvider(toId));
        return const AsyncValue.data(null);
      },
    );
  }
}
