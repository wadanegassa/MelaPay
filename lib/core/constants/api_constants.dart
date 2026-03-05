class ApiConstants {
  static const String baseUrl = 'https://api.melapay.com/v1'; // Mock base URL
  
  static const String wallets = '/wallets';
  static String walletDetails(String id) => '/wallets/$id';
  static String walletTransactions(String id) => '/wallets/$id/transactions';
  
  static String deposit(String id) => '/wallets/$id/deposit';
  static String withdraw(String id) => '/wallets/$id/withdraw';
  static const String transfer = '/wallets/transfer';
  
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}
