import 'package:flutter/material.dart';
import 'package:melapay/features/wallets/domain/entities/wallet.dart';
import 'package:intl/intl.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;
  final VoidCallback onTap;

  const WalletCard({
    super.key,
    required this.wallet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withAlpha(200),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallet ID: ${wallet.id}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                NumberFormat.currency(symbol: '\$').format(wallet.balance),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isNegative = transaction.type == TransactionType.withdraw || transaction.type == TransactionType.transfer;
    final color = isNegative ? Colors.red : Colors.green;
    final icon = transaction.type == TransactionType.deposit
        ? Icons.add_circle_outline
        : transaction.type == TransactionType.withdraw
            ? Icons.remove_circle_outline
            : Icons.swap_horiz;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withAlpha(30),
        child: Icon(icon, color: color),
      ),
      title: Text(
        transaction.description,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        DateFormat.yMMMd().add_jm().format(transaction.timestamp),
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: Text(
        '${isNegative ? "-" : "+"}${NumberFormat.currency(symbol: "\$").format(transaction.amount)}',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
