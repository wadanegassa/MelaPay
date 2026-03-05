# MelaPay - Mobile Wallet Application

A Flutter application demonstrating wallet management, balance tracking, and transaction history.

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK

### Installation & Setup
1. Clone the repository and navigate to the project directory.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run code generation for Riverpod and Freezed:
   ```bash
   dart run build_runner build -d
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Architecture Overview

The project follows a **Feature-Driven Clean Architecture** approach to ensure scalability, testability, and separation of concerns.

### Layer Separation
The codebase is divided into distinct layers within `lib/features/wallets`:
- **Presentation Layer**: Contains UI components (Screens, Widgets) and state management (Riverpod Notifiers). This layer handles no business logic.
- **Domain Layer**: Contains UseCases and Entities. This encapsulates the core business rules (e.g., validating transfer amounts).
- **Data Layer**: Contains Repositories and DataSources, handling API communication and data serialization.

### State Management
State is managed using **Riverpod** with code generation (`riverpod_annotation`). 
- Asynchronous operations are handled cleanly using Riverpod's `AsyncValue` pattern, ensuring loading and error states are consistently represented in the UI without relying on manual boolean flags.

### API Integration & Mocking
To demonstrate API integration without relying on an external backend, the app utilizes **Dio** with a custom stateful `MockInterceptor`.
- The interceptor intercepts real HTTP requests (GET, POST) and processes them against an in-memory data store.
- It simulates network latency, processes transactions (deposits, withdrawals, transfers), updates balances dynamically, and returns standard HTTP responses (including error codes like 400 for insufficient funds).

### UI Implementation
The user interface implements a custom, consistent design system:
- Built with a modern slate and indigo color palette.
- Reusable components (`PrimaryButton`, `WalletCard`, `TransactionTile`) ensure visual consistency across screens.
- Typography is handled centrally using `GoogleFonts`.
