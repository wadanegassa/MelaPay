import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:melapay/features/wallets/presentation/providers/wallet_provider.dart';
import 'package:melapay/shared/widgets/common_widgets.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  final String id;
  const WithdrawScreen({super.key, required this.id});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    await ref.read(walletActionProvider.notifier).withdraw(widget.id, amount);

    if (mounted) {
      final state = ref.read(walletActionProvider);
      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error.toString()), backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Withdrawal successful!'), backgroundColor: Colors.green),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(walletActionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw Money')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            AmountTextField(
              controller: _amountController,
              label: 'Amount to Withdraw',
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Withdraw Now',
              onPressed: _submit,
              isLoading: actionState.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
