import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:melapay/core/constants/api_constants.dart';

class MockInterceptor extends Interceptor {
  static final _mockBox = Hive.box('mock_backend');

  static List<Map<String, dynamic>> get _wallets {
    final data = _mockBox.get('wallets');
    if (data == null) {
      return [
        {'id': 'wallet_1', 'balance': 1500.50},
        {'id': 'wallet_2', 'balance': 500.00},
        {'id': 'wallet_3', 'balance': 25.75},
      ];
    }
    return (data as List).map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static List<Map<String, dynamic>> get _transactions {
    final data = _mockBox.get('transactions');
    if (data == null) {
      return [
        {
          'id': 'tx_1',
          'walletId': 'wallet_1',
          'type': 'deposit',
          'amount': 1000.0,
          'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
          'description': 'Initial deposit'
        },
        {
          'id': 'tx_2',
          'walletId': 'wallet_2',
          'type': 'deposit',
          'amount': 500.0,
          'timestamp': DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
          'description': 'Initial deposit'
        },
      ];
    }
    return (data as List).map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> _saveWallets(List<Map<String, dynamic>> wallets) async {
    await _mockBox.put('wallets', wallets);
  }

  static Future<void> _saveTransactions(List<Map<String, dynamic>> transactions) async {
    await _mockBox.put('transactions', transactions);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final path = options.path;
    final method = options.method;

    // GET /wallets
    if (path == ApiConstants.wallets && method == 'GET') {
      handler.resolve(Response(
        requestOptions: options,
        data: _wallets,
        statusCode: 200,
      ));
      return;
    }

    // GET /wallets/{id}
    if (path.startsWith('/wallets/') && !path.contains('/transactions') && !path.contains('/deposit') && !path.contains('/withdraw') && path != ApiConstants.transfer && method == 'GET') {
      final walletId = path.split('/').last;
      final wallet = _wallets.firstWhere((w) => w['id'] == walletId, orElse: () => {});
      
      if (wallet.isEmpty) {
        handler.reject(DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 404, data: {'error': 'Wallet not found'}),
        ));
      } else {
        handler.resolve(Response(requestOptions: options, data: wallet, statusCode: 200));
      }
      return;
    }

    // GET /wallets/{id}/transactions
    if (path.startsWith('/wallets/') && path.endsWith('/transactions') && method == 'GET') {
      final walletId = path.split('/')[2];
      final walletTransactions = _transactions.where((t) => t['walletId'] == walletId).toList();
      handler.resolve(Response(
        requestOptions: options,
        data: walletTransactions,
        statusCode: 200,
      ));
      return;
    }

    // POST /wallets/{id}/deposit
    if (path.startsWith('/wallets/') && path.endsWith('/deposit') && method == 'POST') {
      final walletId = path.split('/')[2];
      final amount = (options.data['amount'] as num).toDouble();
      
      final wallets = _wallets;
      final walletIndex = wallets.indexWhere((w) => w['id'] == walletId);
      if (walletIndex != -1) {
        wallets[walletIndex]['balance'] += amount;
        await _saveWallets(wallets);

        final transactions = _transactions;
        transactions.insert(0, {
          'id': 'tx_${DateTime.now().millisecondsSinceEpoch}',
          'walletId': walletId,
          'type': 'deposit',
          'amount': amount,
          'timestamp': DateTime.now().toIso8601String(),
          'description': 'Deposit'
        });
        await _saveTransactions(transactions);

        handler.resolve(Response(
          requestOptions: options,
          data: {'success': true, 'message': 'Deposit successful', 'newBalance': wallets[walletIndex]['balance']},
          statusCode: 200,
        ));
      } else {
        handler.reject(DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 404, data: {'error': 'Wallet not found'}),
        ));
      }
      return;
    }

    // POST /wallets/{id}/withdraw
    if (path.startsWith('/wallets/') && path.endsWith('/withdraw') && method == 'POST') {
      final walletId = path.split('/')[2];
      final amount = (options.data['amount'] as num).toDouble();
      
      final wallets = _wallets;
      final walletIndex = wallets.indexWhere((w) => w['id'] == walletId);
      if (walletIndex != -1) {
        if (wallets[walletIndex]['balance'] >= amount) {
          wallets[walletIndex]['balance'] -= amount;
          await _saveWallets(wallets);

          final transactions = _transactions;
          transactions.insert(0, {
            'id': 'tx_${DateTime.now().millisecondsSinceEpoch}',
            'walletId': walletId,
            'type': 'withdraw',
            'amount': amount,
            'timestamp': DateTime.now().toIso8601String(),
            'description': 'Withdrawal'
          });
          await _saveTransactions(transactions);

          handler.resolve(Response(
            requestOptions: options,
            data: {'success': true, 'message': 'Withdrawal successful', 'newBalance': wallets[walletIndex]['balance']},
            statusCode: 200,
          ));
        } else {
          handler.reject(DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              data: {'error': 'Insufficient funds'},
              statusCode: 400,
            ),
            type: DioExceptionType.badResponse,
          ));
        }
      } else {
        handler.reject(DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 404, data: {'error': 'Wallet not found'}),
        ));
      }
      return;
    }

    // POST /wallets/transfer
    if (path == ApiConstants.transfer && method == 'POST') {
      final fromId = options.data['fromId'];
      final toId = options.data['toId'];
      final amount = (options.data['amount'] as num).toDouble();

      final wallets = _wallets;
      final fromIndex = wallets.indexWhere((w) => w['id'] == fromId);
      final toIndex = wallets.indexWhere((w) => w['id'] == toId);

      if (fromIndex != -1 && toIndex != -1) {
        if (wallets[fromIndex]['balance'] >= amount) {
          wallets[fromIndex]['balance'] -= amount;
          wallets[toIndex]['balance'] += amount;
          await _saveWallets(wallets);

          final now = DateTime.now().toIso8601String();
          final transactions = _transactions;
          transactions.insert(0, {
            'id': 'tx_${DateTime.now().millisecondsSinceEpoch}_1',
            'walletId': fromId,
            'type': 'transfer',
            'amount': amount,
            'timestamp': now,
            'description': 'Transfer to $toId'
          });
          transactions.insert(0, {
            'id': 'tx_${DateTime.now().millisecondsSinceEpoch}_2',
            'walletId': toId,
            'type': 'transfer',
            'amount': amount,
            'timestamp': now,
            'description': 'Transfer from $fromId'
          });
          await _saveTransactions(transactions);

          handler.resolve(Response(
            requestOptions: options,
            data: {'success': true, 'message': 'Transfer successful'},
            statusCode: 200,
          ));
        } else {
          handler.reject(DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              data: {'error': 'Insufficient funds for transfer'},
              statusCode: 400,
            ),
            type: DioExceptionType.badResponse,
          ));
        }
      } else {
        handler.reject(DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 404, data: {'error': 'One or both wallets not found'}),
        ));
      }
      return;
    }

    super.onRequest(options, handler);
  }
}

