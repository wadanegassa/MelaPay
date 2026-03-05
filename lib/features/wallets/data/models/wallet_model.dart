import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
class WalletModel with _$WalletModel {
  const factory WalletModel({
    required String id,
    required double balance,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);
}

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String walletId,
    required String type,
    required double amount,
    required String timestamp,
    required String description,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
}

@freezed
class TransferRequestModel with _$TransferRequestModel {
  const factory TransferRequestModel({
    required String fromWalletId,
    required String toWalletId,
    required double amount,
  }) = _TransferRequestModel;

  factory TransferRequestModel.fromJson(Map<String, dynamic> json) => _$TransferRequestModelFromJson(json);
}
