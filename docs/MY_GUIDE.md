# PayWise Owner's Personal Guide

This guide is written in plain English for explaining the project confidently to teachers and evaluators, even without prior Flutter experience.

---

## 1. Flutter in 10 Minutes (Plain English)

- **Widget**: A Lego brick. Every single visual element (text, button, image, container) is a widget.
- **Widget Tree**: How widgets are stacked together. A screen is just a tree of Lego bricks inside a parent brick.
- **State**: The information the app remembers right now (like your wallet balance or if you are logged in).
- **build()**: The factory method where Flutter draws the Lego blocks based on the current state.
- **Scaffold**: The standard blank mobile page template with a top bar, body area, and bottom navigation bar.
- **Column / Row**: Layout bricks that line up widgets vertically (Column) or horizontally (Row).
- **ListView**: A scrollable vertical column that only builds items as you scroll to them.
- **Provider**: A megaphone. When data changes in Firestore, Provider announces it so all screens refresh instantly.
- **async / await**: Asking for something that takes time (like talking to Firebase) without freezing the app while waiting.
- **Firestore Stream**: A live pipeline. When anything changes in the database, the new data flows straight into the app.

---

## 2. How the App Starts (`lib/main.dart`)

1. **`main()`** runs first. It initializes Flutter system hooks and connects Firebase using `DefaultFirebaseOptions`.
2. **`ChangeNotifierProvider`** wraps the root with `AppProvider`.
3. **`PayWiseApp`** sets the light theme and hands navigation over to `appRouter` (configured with `GoRouter`).
4. If a user is not signed in, `GoRouter` redirects to `/login` (`LoginScreen`).
5. Once signed in (via email or "Continue as demo user"), the router opens the main 5-tab shell (`/`).

---

## 3. Where Things Live (Pointer Table)

| Feature | File to Open | What It Does |
|---|---|---|
| Pricing & Limit Rules | `lib/core/pricing_rules.dart` | Daily ₹1,00,000 bank transfer limit, 2 free credit card payments then 1% fee |
| Category Colors & Icons | `lib/core/categories.dart` | 8 spending categories with distinct color tokens and line icons |
| Theme & Tokens | `lib/core/theme/` | Exact colors, font scale (Plus Jakarta Sans), and light theme |
| Database Gateway | `lib/data/firestore_service.dart` | The only file that communicates with Cloud Firestore |
| Demo Seed Data | `lib/data/demo_data.dart` | Generates 40 transactions, 8 contacts, 5 bills, 2 cards, and holdings |
| Auth & Anonymous Login | `lib/data/auth_service.dart` | Handles email sign-in and instant demo login |
| Login Screen | `lib/features/auth/login_screen.dart` | Stitch-matched auth screen with demo access button |
| 5-Tab Shell & Scan Button | `lib/features/home/nav_shell.dart` | Bottom bar with Home, History, Wealth, Services, Rewards + center Scan button |

---

## 4. Viva Cheat Sheet (Top Questions & Honest Answers)

1. **Why Flutter?**
   It allows writing one Dart codebase that compiles natively to Android, iOS, and Web with identical UI.
2. **Why Firebase?**
   Firebase Auth provides instant anonymous and password login, and Cloud Firestore provides live real-time streams with zero server maintenance.
3. **Why Provider for state?**
   Provider is Flutter's official, recommended beginner-friendly pattern. It uses standard Dart listeners without complex boilerplate.
4. **Is real money involved?**
   No, payments are realistically simulated and stored in Cloud Firestore.
5. **How are pricing rules enforced?**
   All rules are centralized in `lib/core/pricing_rules.dart` and backed by automated unit tests in `test/pricing_test.dart`.
6. **How does the web app stay phone-sized?**
   `NavShell` wraps pages in a `ConstrainedBox(maxWidth: 430)` so it retains a realistic mobile shape on wide screens.
