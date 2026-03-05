// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletModelImpl _$$WalletModelImplFromJson(Map<String, dynamic> json) =>
    _$WalletModelImpl(
      id: json['id'] as String,
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$$WalletModelImplToJson(_$WalletModelImpl instance) =>
    <String, dynamic>{'id': instance.id, 'balance': instance.balance};

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: json['id'] as String,
  walletId: json['walletId'] as String,
  type: json['type'] as String,
  amount: (json['amount'] as num).toDouble(),
  timestamp: json['timestamp'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'walletId': instance.walletId,
  'type': instance.type,
  'amount': instance.amount,
  'timestamp': instance.timestamp,
  'description': instance.description,
};

_$TransferRequestModelImpl _$$TransferRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransferRequestModelImpl(
  fromWalletId: json['fromWalletId'] as String,
  toWalletId: json['toWalletId'] as String,
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$$TransferRequestModelImplToJson(
  _$TransferRequestModelImpl instance,
) => <String, dynamic>{
  'fromWalletId': instance.fromWalletId,
  'toWalletId': instance.toWalletId,
  'amount': instance.amount,
};
