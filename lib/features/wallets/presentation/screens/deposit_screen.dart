import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:melapay/features/wallets/presentation/providers/wallet_provider.dart';
import 'package:melapay/shared/widgets/common_widgets.dart';

class DepositScreen extends ConsumerStatefulWidget {
  final String id;
  const DepositScreen({super.key, required this.id});

  @override
  ConsumerState<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends ConsumerState<DepositScreen> {
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

    await ref.read(walletActionProvider.notifier).deposit(widget.id, amount);

    if (mounted) {
      final state = ref.read(walletActionProvider);
      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error.toString()), backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deposit successful!'), backgroundColor: Colors.green),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(walletActionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Deposit Money')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            AmountTextField(
              controller: _amountController,
              label: 'Amount to Deposit',
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Deposit Now',
              onPressed: _submit,
              isLoading: actionState.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
