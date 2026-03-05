import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:melapay/features/wallets/domain/entities/wallet.dart';
import 'package:melapay/features/wallets/presentation/providers/wallet_provider.dart';
import 'package:melapay/shared/widgets/common_widgets.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _amountController = TextEditingController();
  String? _fromId;
  String? _toId;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (_fromId == null || _toId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both wallets')),
      );
      return;
    }

    if (_fromId == _toId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Source and destination wallets must be different')),
      );
      return;
    }

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    await ref.read(walletActionProvider.notifier).transfer(_fromId!, _toId!, amount);

    if (mounted) {
      final state = ref.read(walletActionProvider);
      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error.toString()), backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transfer successful!'), backgroundColor: Colors.green),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletsAsync = ref.watch(walletsProvider);
    final actionState = ref.watch(walletActionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer Money')),
      body: walletsAsync.when(
        data: (wallets) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('From Wallet', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _WalletDropdown(
                value: _fromId,
                wallets: wallets,
                onChanged: (val) => setState(() => _fromId = val),
              ),
              const SizedBox(height: 24),
              const Text('To Wallet', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _WalletDropdown(
                value: _toId,
                wallets: wallets,
                onChanged: (val) => setState(() => _toId = val),
              ),
              const SizedBox(height: 24),
              AmountTextField(
                controller: _amountController,
                label: 'Amount to Transfer',
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                label: 'Transfer Now',
                onPressed: _submit,
                isLoading: actionState.isLoading,
              ),
            ],
          ),
        ),
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(message: error.toString(), onRetry: () => ref.refresh(walletsProvider)),
      ),
    );
  }
}

class _WalletDropdown extends StatelessWidget {
  final String? value;
  final List<Wallet> wallets;
  final ValueChanged<String?> onChanged;

  const _WalletDropdown({this.value, required this.wallets, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: const Text('Select a wallet'),
          onChanged: onChanged,
          items: wallets.map((w) {
            return DropdownMenuItem(
              value: w.id,
              child: Text('${w.id} (\$${w.balance.toStringAsFixed(2)})'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
