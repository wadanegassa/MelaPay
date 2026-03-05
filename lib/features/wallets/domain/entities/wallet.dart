import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String id;
  final double balance;

  const Wallet({
    required this.id,
    required this.balance,
  });

  @override
  List<Object?> get props => [id, balance];
}

enum TransactionType { deposit, withdraw, transfer }

class Transaction extends Equatable {
  final String id;
  final String walletId;
  final TransactionType type;
  final double amount;
  final DateTime timestamp;
  final String description;

  const Transaction({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.timestamp,
    required this.description,
  });

  @override
  List<Object?> get props => [id, walletId, type, amount, timestamp, description];
}
