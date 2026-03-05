# MelaPay - Simple Wallet App

A Flutter take-home project demonstrating wallet management, balance tracking, and transaction history.

## Features
- **Wallet List**: Overview of all wallets and balances.
- **Wallet Details**: Specific wallet view with history.
- **Balance Actions**: Deposit, Withdraw, and Transfer between wallets.
- **Dynamic Updates**: Real-time state updates using a stateful in-memory mock backend.

## Architecture
- **State Management**: Flutter Riverpod (Notifier/riverpod_annotation)
- **Navigation**: GoRouter
- **Networking**: Dio with custom Interceptor for Mock API
- **Design Pattern**: Clean Architecture (Feature-driven)

## Setup
1. Ensure you have Flutter installed.
2. Run `flutter pub get`
3. Run `flutter analyze` to verify the codebase.
4. Run `flutter run` to launch the app.
