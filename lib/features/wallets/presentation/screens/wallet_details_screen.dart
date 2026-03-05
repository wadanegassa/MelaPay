import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
                        icon: Icons.arrow_downward_rounded,
                        label: 'Deposit',
                        color: const Color(0xFF00A9FF),
                        onTap: () => context.push('/deposit/$id'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ActionButton(
                        icon: Icons.arrow_upward_rounded,
                        label: 'Withdraw',
                        color: const Color(0xFFF05941),
                        onTap: () => context.push('/withdraw/$id'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Recent Transactions',
                  style: GoogleFonts.inter(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D3250),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              transactionsAsync.when(
                data: (transactions) => transactions.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Center(
                          child: Text(
                            'No transactions yet.',
                            style: GoogleFonts.inter(color: const Color(0xFF7077A1)),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF2D3250),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
