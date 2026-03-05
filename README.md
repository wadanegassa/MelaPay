# MelaPay - Mobile Wallet Application

Hey! Thanks for taking the time to review my submission for the wallet application take-home project. 

Below you'll find instructions on how to run the app, along with a breakdown of why I structured the project the way I did.

## How to Run the App

Running the project is straightforward:

1. Make sure you have the Flutter SDK installed on your machine.
2. Clone this repository and `cd` into the project root.
3. Fetch the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the code generator (already done, but good practice if you change providers/models):
   ```bash
   dart run build_runner build -d
   ```
5. Run the app on your preferred simulator/emulator:
   ```bash
   flutter run
   ```
   *(Note: I've primarily tested this on iOS/Android simulators).*

## Architecture & Design Decisions

I decided to go with a **Feature-Driven Clean Architecture**. While a simple flat folder structure (just throwing everything into `lib/screens` and `lib/models`) works for tiny apps, it becomes a nightmare to maintain as the app grows. 

By grouping files by feature (`lib/features/wallets`) and splitting them into **Data**, **Domain**, and **Presentation** layers, the codebase becomes incredibly easy to test, scale, and navigate. 

### Separation of Concerns (UI vs. Logic)
I made a strict rule: **The UI should only draw things.** 

You won't find any HTTP requests, API logic, or complex state manipulation inside the Flutter widgets (`screens`/`widgets`). All of that is pushed down into:
- **Presentation:** Handled by Riverpod `Notifier` classes (e.g., `walletActionProvider`). This handles loading/error/success states.
- **Domain:** The UseCases (e.g., `DepositUseCase`) hold the business rules (like making sure you don't transfer negative money).
- **Data:** The Repositories and DataSources handle the actual API communication and JSON parsing.

### State Management & Loading/Error States
I chose **Riverpod** (with code generation) because it's arguably the most robust and type-safe state management solution for Flutter right now. 

To handle loading and error states cleanly, I heavily relied on Riverpod's `AsyncValue` (`.when(data:, loading:, error:)`). This pattern eliminates the need for messy `bool isLoading;` variables scattered around the UI, guaranteeing that the user always sees a loading spinner during network requests and a clear error message if something fails.

### API Integration (The Mock Backend)
Since the prompt asked to handle API communication but didn't provide a backend, I built a stateful `MockInterceptor` using **Dio**. 

Instead of just hardcoding UI states, the app actually makes HTTP requests (e.g., `POST /wallets/{id}/deposit`). The interceptor catches these, processes them against an in-memory storage, simulates network latency, and returns proper JSON responses (or HTTP errors like 400s if you try to withdraw more than you have). This allowed me to demonstrate real API integration patterns (using Repositories, DataSources, and error mapping) exactly as I would with a production backend.

### UI Architecture
For the UI, I built a small custom theme centered around a "Modern Slate" aesthetic. I didn't spend weeks on it, but I wanted it to feel clean and professional rather than relying purely on default Material grey buttons. I used `GoogleFonts.inter` for clean typography and extracted things like `PrimaryButton`, `WalletCard`, and `TransactionTile` into reusable widgets.

---
If you run into any issues running the app or have questions about the code, just let me know!
