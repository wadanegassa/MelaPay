import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:melapay/features/wallets/presentation/providers/wallet_provider.dart';
import 'package:melapay/features/wallets/presentation/widgets/wallet_widgets.dart';
import 'package:melapay/shared/widgets/common_widgets.dart';

class WalletDetailsScreen extends ConsumerWidget {
  final String id;

  const WalletDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletDetailsProvider(id));
    final transactionsAsync = ref.watch(transactionsProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet Details')),
      body: walletAsync.when(
        data: (wallet) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(walletDetailsProvider(id));
            ref.invalidate(transactionsProvider(id));
            await ref.read(walletDetailsProvider(id).future);
            await ref.read(transactionsProvider(id).future);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              WalletCard(wallet: wallet, onTap: () {}),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: ActionButton(
                        icon: Icons.add,
                        label: 'Deposit',
                        color: Colors.green,
                        onTap: () => context.push('/deposit/$id'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ActionButton(
                        icon: Icons.remove,
                        label: 'Withdraw',
                        color: Colors.red,
                        onTap: () => context.push('/withdraw/$id'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              transactionsAsync.when(
                data: (transactions) => transactions.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(child: Text('No transactions yet.')),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                        itemBuilder: (context, index) => TransactionTile(transaction: transactions[index]),
                      ),
                loading: () => const LoadingIndicator(),
                error: (error, _) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text('Error loading transactions: $error'),
                ),
              ),
            ],
          ),
        ),
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(walletDetailsProvider(id)),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withAlpha(20),
        foregroundColor: color,
        elevation: 0,
        side: BorderSide(color: color.withAlpha(40)),
      ),
    );
  }
}
