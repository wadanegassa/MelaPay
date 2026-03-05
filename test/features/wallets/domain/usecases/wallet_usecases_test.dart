import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melapay/features/wallets/domain/repositories/wallet_repository.dart';
import 'package:melapay/features/wallets/domain/usecases/wallet_usecases.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'wallet_usecases_test.mocks.dart';

@GenerateMocks([WalletRepository])
void main() {
  late DepositUseCase depositUseCase;
  late WithdrawUseCase withdrawUseCase;
  late TransferUseCase transferUseCase;
  late MockWalletRepository mockRepository;

  setUp(() {
    mockRepository = MockWalletRepository();
    depositUseCase = DepositUseCase(mockRepository);
    withdrawUseCase = WithdrawUseCase(mockRepository);
    transferUseCase = TransferUseCase(mockRepository);
  });

  group('Wallet UseCases', () {
    test('DepositUseCase should call repository when amount is valid', () async {
      when(mockRepository.deposit('w1', 100.0)).thenAnswer((_) async => const Right(null));

      final result = await depositUseCase.execute('w1', 100.0);

      expect(result, const Right(null));
      verify(mockRepository.deposit('w1', 100.0)).called(1);
    });

    test('WithdrawUseCase should return Left when amount is negative', () async {
      final result = await withdrawUseCase.execute('w1', -50.0);

      expect(result.isLeft(), true);
      verifyNever(mockRepository.withdraw(any, any));
    });

    test('TransferUseCase should return Left when source and destination are same', () async {
      final result = await transferUseCase.execute('w1', 'w1', 100.0);

      expect(result.isLeft(), true);
      verifyNever(mockRepository.transfer(any, any, any));
    });
  });
}
