// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiClientHash() => r'f4a9ab68cfa9f717d6af63ef2e95b92d46ea300e';

/// See also [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = AutoDisposeProvider<ApiClient>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiClientRef = AutoDisposeProviderRef<ApiClient>;
String _$walletRepositoryHash() => r'a6d379510fed32be45a42568fae7385c9213080e';

/// See also [walletRepository].
@ProviderFor(walletRepository)
final walletRepositoryProvider = AutoDisposeProvider<WalletRepository>.internal(
  walletRepository,
  name: r'walletRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletRepositoryRef = AutoDisposeProviderRef<WalletRepository>;
String _$getWalletsUseCaseHash() => r'05685d95085006179bb3661bdaef45d4b8db120e';

/// See also [getWalletsUseCase].
@ProviderFor(getWalletsUseCase)
final getWalletsUseCaseProvider =
    AutoDisposeProvider<GetWalletsUseCase>.internal(
      getWalletsUseCase,
      name: r'getWalletsUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getWalletsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetWalletsUseCaseRef = AutoDisposeProviderRef<GetWalletsUseCase>;
String _$getWalletUseCaseHash() => r'9123a50592c12c228f718f15d871663f3844019b';

/// See also [getWalletUseCase].
@ProviderFor(getWalletUseCase)
final getWalletUseCaseProvider = AutoDisposeProvider<GetWalletUseCase>.internal(
  getWalletUseCase,
  name: r'getWalletUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getWalletUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetWalletUseCaseRef = AutoDisposeProviderRef<GetWalletUseCase>;
String _$getTransactionsUseCaseHash() =>
    r'c95ac2dce558724568bffc33e139117231d30349';

/// See also [getTransactionsUseCase].
@ProviderFor(getTransactionsUseCase)
final getTransactionsUseCaseProvider =
    AutoDisposeProvider<GetTransactionsUseCase>.internal(
      getTransactionsUseCase,
      name: r'getTransactionsUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getTransactionsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTransactionsUseCaseRef =
    AutoDisposeProviderRef<GetTransactionsUseCase>;
String _$depositUseCaseHash() => r'ab98d30d47b2dbd31c5c45a472dc3c394ddcf920';

/// See also [depositUseCase].
@ProviderFor(depositUseCase)
final depositUseCaseProvider = AutoDisposeProvider<DepositUseCase>.internal(
  depositUseCase,
  name: r'depositUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$depositUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DepositUseCaseRef = AutoDisposeProviderRef<DepositUseCase>;
String _$withdrawUseCaseHash() => r'afc2228cef53f37d9379f5d7ec5fe565d9d0e092';

/// See also [withdrawUseCase].
@ProviderFor(withdrawUseCase)
final withdrawUseCaseProvider = AutoDisposeProvider<WithdrawUseCase>.internal(
  withdrawUseCase,
  name: r'withdrawUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$withdrawUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WithdrawUseCaseRef = AutoDisposeProviderRef<WithdrawUseCase>;
String _$transferUseCaseHash() => r'47e78c13c5161a2040788a73707ce47cce423f83';

/// See also [transferUseCase].
@ProviderFor(transferUseCase)
final transferUseCaseProvider = AutoDisposeProvider<TransferUseCase>.internal(
  transferUseCase,
  name: r'transferUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transferUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransferUseCaseRef = AutoDisposeProviderRef<TransferUseCase>;
String _$walletsHash() => r'3bdfc63192bfd015a30b6b27699070859056a98f';

/// See also [wallets].
@ProviderFor(wallets)
final walletsProvider = AutoDisposeFutureProvider<List<Wallet>>.internal(
  wallets,
  name: r'walletsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletsRef = AutoDisposeFutureProviderRef<List<Wallet>>;
String _$walletDetailsHash() => r'28be847d0963801b996f5d721980f15b27f2f5dd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [walletDetails].
@ProviderFor(walletDetails)
const walletDetailsProvider = WalletDetailsFamily();

/// See also [walletDetails].
class WalletDetailsFamily extends Family<AsyncValue<Wallet>> {
  /// See also [walletDetails].
  const WalletDetailsFamily();

  /// See also [walletDetails].
  WalletDetailsProvider call(String id) {
    return WalletDetailsProvider(id);
  }

  @override
  WalletDetailsProvider getProviderOverride(
    covariant WalletDetailsProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'walletDetailsProvider';
}

/// See also [walletDetails].
class WalletDetailsProvider extends AutoDisposeFutureProvider<Wallet> {
  /// See also [walletDetails].
  WalletDetailsProvider(String id)
    : this._internal(
        (ref) => walletDetails(ref as WalletDetailsRef, id),
        from: walletDetailsProvider,
        name: r'walletDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$walletDetailsHash,
        dependencies: WalletDetailsFamily._dependencies,
        allTransitiveDependencies:
            WalletDetailsFamily._allTransitiveDependencies,
        id: id,
      );

  WalletDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Wallet> Function(WalletDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WalletDetailsProvider._internal(
        (ref) => create(ref as WalletDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Wallet> createElement() {
    return _WalletDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WalletDetailsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WalletDetailsRef on AutoDisposeFutureProviderRef<Wallet> {
  /// The parameter `id` of this provider.
  String get id;
}

class _WalletDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Wallet>
    with WalletDetailsRef {
  _WalletDetailsProviderElement(super.provider);

  @override
  String get id => (origin as WalletDetailsProvider).id;
}

String _$transactionsHash() => r'0f45fee8bc70fe0d7d62ffaa967ce0340239ec9b';

/// See also [transactions].
@ProviderFor(transactions)
const transactionsProvider = TransactionsFamily();

/// See also [transactions].
class TransactionsFamily extends Family<AsyncValue<List<Transaction>>> {
  /// See also [transactions].
  const TransactionsFamily();

  /// See also [transactions].
  TransactionsProvider call(String walletId) {
    return TransactionsProvider(walletId);
  }

  @override
  TransactionsProvider getProviderOverride(
    covariant TransactionsProvider provider,
  ) {
    return call(provider.walletId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'transactionsProvider';
}

/// See also [transactions].
class TransactionsProvider
    extends AutoDisposeFutureProvider<List<Transaction>> {
  /// See also [transactions].
  TransactionsProvider(String walletId)
    : this._internal(
        (ref) => transactions(ref as TransactionsRef, walletId),
        from: transactionsProvider,
        name: r'transactionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$transactionsHash,
        dependencies: TransactionsFamily._dependencies,
        allTransitiveDependencies:
            TransactionsFamily._allTransitiveDependencies,
        walletId: walletId,
      );

  TransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.walletId,
  }) : super.internal();

  final String walletId;

  @override
  Override overrideWith(
    FutureOr<List<Transaction>> Function(TransactionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionsProvider._internal(
        (ref) => create(ref as TransactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        walletId: walletId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Transaction>> createElement() {
    return _TransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsProvider && other.walletId == walletId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, walletId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionsRef on AutoDisposeFutureProviderRef<List<Transaction>> {
  /// The parameter `walletId` of this provider.
  String get walletId;
}

class _TransactionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Transaction>>
    with TransactionsRef {
  _TransactionsProviderElement(super.provider);

  @override
  String get walletId => (origin as TransactionsProvider).walletId;
}

String _$walletActionHash() => r'd069fc4a296f0a1d76b2eb5a3aa8948e9be9fc75';

/// See also [WalletAction].
@ProviderFor(WalletAction)
final walletActionProvider =
    AutoDisposeNotifierProvider<WalletAction, AsyncValue<void>>.internal(
      WalletAction.new,
      name: r'walletActionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$walletActionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WalletAction = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
