# PayWise Owner's Personal Guide & Viva Preparation

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
| History & Donut Chart | `lib/features/history/history_screen.dart` | Interactive `fl_chart` donut and transaction audit sheet |
| Bills & Autopay | `lib/features/bills/bills_screen.dart` | Utility bill payment with Autopay frequency selector |
| Credit Card 1% Fee Rule | `lib/features/bills/credit_card_bill_screen.dart` | Card settlements with automatic fee preview |
| Wealth & Digital Gold | `lib/features/wealth/digital_gold_screen.dart` | Live ticking 24K gold rate with instant buy/sell |
| Insurance Discovery | `lib/features/insurance/insurance_screen.dart` | Policy selector and 4-step claim status progress |
| Lending & Live EMI | `lib/features/lending/lending_screen.dart` | Interactive loan slider with live EMI calculation |
| Rewards & Scratch Cards | `lib/features/wallet/rewards_screen.dart` | Scratch card reveal animations and voucher redemption |
| Profile & Debug Panel | `lib/features/profile/profile_screen.dart` | QR modal, failure toggle, and session logout |

---

## 4. Viva Cheat Sheet (Top Questions & Honest Answers)

1. **Why Flutter instead of React Native or Native Android?**
   Flutter compiles directly to native ARM machine code and WebAssembly/CanvasKit with zero runtime JavaScript bridge, ensuring 60fps animations and pixel-identical rendering on both Android and Web.
2. **Why Firebase Firestore over traditional SQL?**
   Firestore is a document database offering real-time streaming listeners (`snapshots()`). When a payment completes or gold is purchased, the UI updates instantly across all open screens without manual polling or page reloads.
3. **Why Provider for state management instead of Bloc or Riverpod?**
   Provider is Flutter's official, recommended state management solution. It relies on standard Dart `ChangeNotifier`, making it easy to reason about, maintain, and test without unnecessary boilerplate.
4. **Is real money involved?**
   No. All financial transactions, UPI simulations, and gold purchases are realistically simulated and persisted in Google Cloud Firestore.
5. **How are pricing rules enforced?**
   All rules are centralized in `lib/core/pricing_rules.dart` and backed by automated unit tests in `test/pricing_test.dart`.
6. **How does the web app stay phone-sized on a desktop monitor?**
   `NavShell` wraps all pages inside a `ConstrainedBox(maxWidth: 430)` centered on screen, retaining a realistic smartphone aspect ratio.
7. **How is code readability and maintainability ensured?**
   Every single `.dart` file is kept under 150 lines, and complex widgets are decomposed into reusable sub-widgets.

---

## 5. Live Demonstration Script for Examiners (5 Minutes)

1. **Step 1 - Authentication**:
   - Open `https://paywise-ae977.web.app`.
   - Click "Continue as demo user" to sign in instantly with a seeded demo account.
2. **Step 2 - Quick Payment & PayPause Friction**:
   - Tap "To Mobile / Contact" on the Home dashboard.
   - Choose a contact (e.g., "Aarav Sharma").
   - Type `2500` into the custom numpad and tap Pay.
   - Show the examiner the **PayPause Mindful Sheet**: explain that any payment $\ge$ ₹2,000 triggers a 3-second reflection pause showing month-to-date category spend.
   - Confirm payment $\to$ see the green checkmark success screen.
3. **Step 3 - Real-Time History & Donut Chart**:
   - Tap the "History" tab in the bottom bar.
   - Point out the interactive Donut chart (`fl_chart`) and the newly inserted transaction at the top of the list.
   - Tap the transaction to reveal the detailed UTR audit bottom sheet.
4. **Step 4 - Credit Card Fee Rule**:
   - Tap "Services" $\to$ "Credit Card Bill".
   - Show the fee badge: first 2 card payments are free, subsequent card payments calculate a 1% convenience fee automatically.
5. **Step 5 - Digital Gold Live Ticker**:
   - Tap "Wealth" $\to$ "Digital Gold".
   - Show the ticking live gold rate (₹7,420/g with market fluctuation) and buy ₹500 of gold.
   - Observe the vault balance increment immediately.
6. **Step 6 - Profile & Debug Tools**:
   - Tap the top-left profile avatar to open `/profile`.
   - Show the personal UPI QR preview modal and explain the failure simulation toggle for testing resilience.

