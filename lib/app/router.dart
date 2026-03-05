
import 'package:go_router/go_router.dart';
import 'package:melapay/features/wallets/presentation/screens/deposit_screen.dart';
import 'package:melapay/features/wallets/presentation/screens/transfer_screen.dart';
import 'package:melapay/features/wallets/presentation/screens/wallet_details_screen.dart';
import 'package:melapay/features/wallets/presentation/screens/wallet_list_screen.dart';
import 'package:melapay/features/wallets/presentation/screens/withdraw_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/wallets',
  routes: [
    GoRoute(
      path: '/wallets',
      builder: (context, state) => const WalletListScreen(),
    ),
    GoRoute(
      path: '/wallet/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return WalletDetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: '/deposit/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DepositScreen(id: id);
      },
    ),
    GoRoute(
      path: '/withdraw/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return WithdrawScreen(id: id);
      },
    ),
    GoRoute(
      path: '/transfer',
      builder: (context, state) => const TransferScreen(),
    ),
  ],
);
