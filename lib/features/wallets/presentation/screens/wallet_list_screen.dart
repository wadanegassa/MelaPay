import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:melapay/features/wallets/presentation/providers/wallet_provider.dart';
import 'package:melapay/features/wallets/presentation/widgets/wallet_widgets.dart';
import 'package:melapay/shared/widgets/common_widgets.dart';

class WalletListScreen extends ConsumerWidget {
  const WalletListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletsAsync = ref.watch(walletsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('My Wallets', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: walletsAsync.when(
        data: (wallets) => RefreshIndicator(
          onRefresh: () => ref.refresh(walletsProvider.future),
          child: wallets.isEmpty
              ? const Center(child: Text('No wallets found.'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: wallets.length,
                  itemBuilder: (context, index) {
                    final wallet = wallets[index];
                    return WalletCard(
                      wallet: wallet,
                      onTap: () => context.push('/wallet/${wallet.id}'),
                    );
                  },
                ),
        ),
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(walletsProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/transfer'),
        label: const Text('Transfer'),
        icon: const Icon(Icons.swap_horiz),
      ),
    );
  }
}
