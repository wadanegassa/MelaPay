import 'package:melapay/core/constants/api_constants.dart';
import 'package:melapay/core/network/api_client.dart';
import 'package:melapay/features/wallets/data/datasources/wallet_remote_datasource.dart';
import 'package:melapay/features/wallets/data/models/wallet_model.dart';

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final ApiClient _apiClient;

  WalletRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<WalletModel>> getWallets() async {
    final response = await _apiClient.get(ApiConstants.wallets);
    return (response.data as List).map((e) => WalletModel.fromJson(e)).toList();
  }

  @override
  Future<WalletModel> getWallet(String id) async {
    final response = await _apiClient.get(ApiConstants.walletDetails(id));
    return WalletModel.fromJson(response.data);
  }

  @override
  Future<List<TransactionModel>> getTransactions(String walletId) async {
    final response = await _apiClient.get(ApiConstants.walletTransactions(walletId));
    return (response.data as List).map((e) => TransactionModel.fromJson(e)).toList();
  }

  @override
  Future<void> deposit(String id, double amount) async {
    await _apiClient.post(ApiConstants.deposit(id), data: {'amount': amount});
  }

  @override
  Future<void> withdraw(String id, double amount) async {
    await _apiClient.post(ApiConstants.withdraw(id), data: {'amount': amount});
  }

  @override
  Future<void> transfer(String fromId, String toId, double amount) async {
    await _apiClient.post(ApiConstants.transfer, data: {
      'fromId': fromId,
      'toId': toId,
      'amount': amount,
    });
  }
}
