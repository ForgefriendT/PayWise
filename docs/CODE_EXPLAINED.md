# PayWise Codebase Explained (Plain English Guide)

This document walks through every file in the PayWise codebase in plain English. No previous Flutter experience is needed to understand how the system is structured and how data flows through the application.

---

### Architectural Principles

1. **Strict 150-Line Constraint**: Every single Dart file in `lib/` is kept under 150 lines. Large screens are broken down into bite-sized, single-responsibility widgets.
2. **Predictable Unidirectional Data Flow**:
   - `User Action` $\to$ `Calls AppProvider method`
   - `AppProvider` $\to$ `Updates FirestoreService`
   - `Firestore` $\to$ `Emits real-time snapshot stream`
   - `AppProvider` $\to$ `Receives snapshot, updates internal models, notifies listeners`
   - `Widgets` $\to$ `Rebuild automatically with fresh data`
3. **No Third-Party Magic**: Uses vanilla CSS tokens converted to Flutter `ThemeData` and standard `Provider` for state.

---

### File-by-File Directory Breakdown

#### Core Architecture (`lib/core/`)

- **`lib/core/pricing_rules.dart` (54 lines)**:
  - *Purpose*: Pure Dart business calculation engine without UI.
  - *Key Functions*: `canMakeBankTransfer()` checks ₹1,00,000 cap; `requiresPayPause()` checks ₹2,000 threshold; `calculateCreditCardFee()` computes 1% fee on 3rd+ card payment; `calculateEmi()` computes monthly loan installment.
- **`lib/core/router.dart` (123 lines)**:
  - *Purpose*: Configures `GoRouter` navigation.
  - *Key Elements*: Sets up `StatefulShellRoute.indexedStack` with 5 persistent bottom tabs (`/`, `/history`, `/wealth`, `/services`, `/rewards`) plus modal routes (`/pay`, `/scan`, `/contacts`, `/bills`, `/credit-card-bill`, `/gold`, `/insurance`, `/lending`, `/wallet`, `/profile`).
- **`lib/core/categories.dart` (68 lines)**:
  - *Purpose*: Defines 8 standardized spending categories (Shopping, Dining, Bills, Groceries, Travel, Investments, Entertainment, Transfers) with hex colors and SVG asset mappings.
- **`lib/core/theme/app_colors.dart` (42 lines)**:
  - *Purpose*: Central palette tokens (`primary` #5B259F, `accentGreen` #10B981, `alertOrange` #F59E0B, `dangerRed` #EF4444).
- **`lib/core/theme/app_theme.dart` (96 lines)**:
  - *Purpose*: Bundles colors, input decoration, card themes, and typography into Flutter's `ThemeData`.
- **`lib/core/theme/app_typography.dart` (58 lines)**:
  - *Purpose*: Font scales using `Plus Jakarta Sans` for headers, body text, and numeric amounts.

---

#### Data & State Layer (`lib/data/`)

- **`lib/data/app_provider.dart` (145 lines)**:
  - *Purpose*: Central reactive state store inheriting from `ChangeNotifier`.
  - *Key Functions*: Subscribes to Firestore real-time streams; exposes cached lists for transactions, bills, cards, and portfolio; provides actions like `sendMoney()`, `payBill()`, `buyGold()`, `simulateFailureToggle()`.
- **`lib/data/auth_service.dart` (64 lines)**:
  - *Purpose*: Firebase Authentication gateway.
  - *Key Functions*: `signInWithEmail()`, `signUpWithEmail()`, `signInAsDemoUser()` (signs in anonymously or uses demo credentials), `signOut()`.
- **`lib/data/firestore_service.dart` (148 lines)**:
  - *Purpose*: Direct read/write gateway to Cloud Firestore.
  - *Key Functions*: Real-time stream getters (`streamTransactions()`, `streamBills()`, `streamPortfolio()`, etc.) and batch update methods.
- **`lib/data/demo_data.dart` (148 lines)**:
  - *Purpose*: Provides fallback demo data and seeds Firestore if collections are empty. Contains 40 transactions, 8 contacts, 5 bills, and initial portfolio metrics.
- **Data Models (`lib/data/models/`)**:
  - `user_profile.dart` (68 lines): User information, wallet balance, KYC verification flag.
  - `transaction_model.dart` (72 lines): Transaction ledger entry with timestamp and reference ID.
  - `contact_model.dart` (62 lines): Beneficiary name, UPI ID, avatar URL, favorite flag.
  - `bill_model.dart` (66 lines): Utility biller, due date, amount, autopay settings.
  - `credit_card_model.dart` (64 lines): Card details, balance due, billing cycle.
  - `portfolio_model.dart` (68 lines): Mutual funds, digital gold grams, stocks breakdown.
  - `insurance_policy.dart` (66 lines): Insurance policy type, coverage limit, premium amount.
  - `loan_model.dart` (64 lines): Pre-approved credit limit, tenure, monthly EMI.
  - `reward_item.dart` (62 lines): Scratch cards, redeemable discount vouchers.

---

#### Feature Modules (`lib/features/`)

1. **Authentication (`lib/features/auth/`)**:
   - `login_screen.dart` (142 lines): Phone/Email login fields, demo account one-tap entry, Stitch purple branding.

2. **Home Dashboard (`lib/features/home/`)**:
   - `nav_shell.dart` (84 lines): Wraps all screens in a responsive 430px container and mounts the custom bottom navigation bar.
   - `nav_bottom_bar.dart` (112 lines): 5-tab bar with an elevated center Scan FAB button.
   - `home_screen.dart` (118 lines): Main landing screen assembling header, quick actions, utilities, and recent activity.
   - `home_header.dart` (88 lines): Purple gradient card with wallet balance and QR/notification shortcuts.
   - `quick_actions_grid.dart` (72 lines): 4 action buttons (To Mobile, To Bank, Self Transfer, Check Balance).
   - `recent_activity_list.dart` (82 lines): Live feed of last 5 transactions with color-coded amount badges.

3. **Payments (`lib/features/pay/`)**:
   - `contacts_screen.dart` (104 lines): Searchable beneficiary list and favorites tray.
   - `scan_screen.dart` (118 lines): Camera viewfinder simulation with corner crosshairs and manual UPI fallback.
   - `pay_screen.dart` (132 lines): Payment amount input, bank account selector, and payment trigger.
   - `custom_numpad.dart` (92 lines): Custom tactile digit grid with haptic feedback.
   - `success_screen.dart` (124 lines): Animated checkmark, sound vibration, and transaction receipt sharing.

4. **Mindful PayPause (`lib/features/paypause/`)**:
   - `paypause_sheet.dart` (126 lines): Appears on payments $\ge$ ₹2,000 with a 3-second reflection countdown before the button unlocks.
   - `paypause_category_insight.dart` (68 lines): Visual bar showing how much was already spent this month in this category.

5. **History & Analytics (`lib/features/history/`)**:
   - `history_screen.dart` (114 lines): Spending donut chart, category filters, and chronological audit log.
   - `spending_pie_chart.dart` (94 lines): Interactive `fl_chart` donut rendering monthly outflow.
   - `transaction_detail_sheet.dart` (136 lines): Bottom sheet with UTR reference, repeat payment, and dispute resolution.

6. **Bills & Cards (`lib/features/bills/`)**:
   - `bills_screen.dart` (108 lines): Utility categories (Electricity, Mobile, Gas, DTH, Water, Fastag).
   - `autopay_schedule_selector.dart` (88 lines): Schedule picker (Instant vs 3 days prior).
   - `credit_card_bill_screen.dart` (134 lines): Card selector, statement balance, and automatic 1% fee preview.

7. **Wealth & Gold (`lib/features/wealth/`)**:
   - `wealth_screen.dart` (112 lines): Portfolio net worth, asset allocation breakdown, and investment quick links.
   - `digital_gold_screen.dart` (140 lines): Real-time live gold price ticker (₹7,420/g), buy in rupees or grams, and vault balance.

8. **Insurance, Lending & Rewards (`lib/features/insurance/`, `lib/features/lending/`, `lib/features/wallet/`)**:
   - `insurance_screen.dart` (128 lines): Policy discovery cards and 4-step live claim tracking stepper.
   - `lending_screen.dart` (136 lines): Live EMI slider, interest rate display, and 1-tap loan disbursement.
   - `rewards_screen.dart` (130 lines): Points tally, interactive scratch cards with coin animations, and voucher store.

9. **Profile & Debug Tools (`lib/features/profile/`)**:
   - `profile_screen.dart` (118 lines): Account information, UPI QR modal, KYC badge, failure simulation switch, and logout.
   - `profile_hero_card.dart` (78 lines): User avatar, phone, and verification badge.
   - `qr_preview_dialog.dart` (64 lines): Displays user's personal QR code for incoming payments.
