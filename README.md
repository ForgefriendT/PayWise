# PayWise: Mindful UPI & Wealth Ecosystem

[![Flutter Web Live](https://img.shields.io/badge/Live%20Demo-paywise--ae977.web.app-5B259F?style=for-the-badge&logo=google-chrome&logoColor=white)](https://paywise-ae977.web.app)
[![Flutter Tests](https://img.shields.io/badge/Tests-23%20Passing-10B981?style=for-the-badge&logo=flutter&logoColor=white)](https://github.com/ForgefriendT/PayWise)
[![Firebase](https://img.shields.io/badge/Backend-Firebase%20Firestore-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

A production-grade, PhonePe-inspired fintech application built with **Flutter 3 (Web & Mobile)** and powered by **Firebase** (Authentication & Cloud Firestore). Designed around the ethos of *mindful financial management*, PayWise blends rapid UPI payments, automated bill settlements, intelligent debt management, physical-backed digital wealth, personalized insurance coverage, instant micro-lending, and gamified cashback rewards into a coherent, responsive mobile-first experience.

---

## Live Deployment & GitHub Links

- **Live Web App**: [https://paywise-ae977.web.app](https://paywise-ae977.web.app)
- **GitHub Repository**: [https://github.com/ForgefriendT/PayWise](https://github.com/ForgefriendT/PayWise)
- **Official Documentation PDFs**:
  - [`PROJECT_DOCUMENTATION.pdf`](./PROJECT_DOCUMENTATION.pdf)
  - [`CODE_EXPLAINED.pdf`](./CODE_EXPLAINED.pdf)
  - [`MY_GUIDE.pdf`](./MY_GUIDE.pdf)

---

## System Architecture

```
+-------------------------------------------------------------------------+
|                              PRESENTATION LAYER                         |
|   Flutter 3.x (Web / iOS / Android) | GoRouter Navigation Shell          |
|   Responsive 430px Max-Width Center Container | Vanilla Custom Tokens    |
+-------------------------------------------------------------------------+
                                    |
                                    v
+-------------------------------------------------------------------------+
|                           STATE MANAGEMENT LAYER                        |
|   ChangeNotifier (AppProvider) | Centralized Reactive State Engine      |
|   Firestore Stream Subscriptions (Transactions, Portfolio, Profile, etc.)|
+-------------------------------------------------------------------------+
                                    |
                                    v
+-------------------------------------------------------------------------+
|                             DATA ACCESS LAYER                           |
|   FirestoreService (Singleton Gateway) | AuthService (Email & Demo Auth) |
|   PricingEngine (Pure Dart Business Logic - Limits, Fees, Schedules)    |
+-------------------------------------------------------------------------+
                                    |
                                    v
+-------------------------------------------------------------------------+
|                             BACKEND SERVICES                            |
|   Firebase Authentication (Email & Anonymous Guest Sign-In)             |
|   Google Cloud Firestore (9 Real-Time Collections & Structured Documents)|
|   Firebase Hosting (Global CDN with Zero-Cache Web App Serving)         |
+-------------------------------------------------------------------------+
```

---

## 18-Screen Stitch Feature Matrix

| # | Screen Name | Route / Modal | Core Capabilities |
|---|---|---|---|
| **01** | **Login & Auth** | `/login` | Phone / Email sign in + one-tap "Continue as demo user" instant session |
| **02** | **Home Dashboard** | `/` (Tab 0) | Wallet balance card, quick actions, 8 utility shortcuts, recent activity feed |
| **03** | **QR Scanner** | `/scan` | Viewfinder crosshairs simulation, torch toggle, gallery picker, manual UPI entry |
| **04** | **Contacts & Beneficiaries** | `/contacts` | Beneficiary directory, search filter, favorites carousel, tap-to-pay |
| **05** | **Pay & Amount** | `/pay` | Custom tactile numpad, bank selector, note attachment, instant transfer |
| **06** | **PayPause Friction** | Bottom Sheet | Mindful friction on $\ge$ ₹2,000 spend: 3s reflection timer & budget impact bar |
| **07** | **Payment Success** | Modal | Checkmark animation, transaction summary, sound haptics, receipt sharing |
| **08** | **History & Analytics** | `/history` (Tab 1) | Interactive `fl_chart` donut spending chart, month selector, category chips |
| **09** | **Transaction Detail** | Bottom Sheet | UTR reference number, audit trail breakdown, repeat payment, dispute link |
| **10** | **Bills & Recharges Hub** | `/bills` / `/services` (Tab 3) | 10 service categories (Electricity, Mobile, Gas, etc.) + autopay reminders |
| **11** | **Autopay Setup** | Bottom Sheet | Schedule trigger (Instant, 3-day notice, Salary day) & monthly safety cap |
| **12** | **Credit Card Bill** | `/credit-card-bill` | Linked cards carousel, due dates, minimum vs custom pay, 1% fee calculation |
| **13** | **Wealth Dashboard** | `/wealth` (Tab 2) | Total portfolio net worth, return metrics, asset allocation bar, SIP links |
| **14** | **Digital Gold** | `/gold` | Live ticking 24K gold rate (₹7,420/g $\pm$ variance), rupee/gram buy, vault |
| **15** | **Insurance Discovery** | `/insurance` | Health, car, term life policy cards + 4-step interactive claim tracker |
| **16** | **Lending & Loan Eligibility**| `/lending` | Pre-approved credit limit slider (up to ₹2.5L), tenure picker, live EMI math |
| **17** | **Rewards & Wallet Hub** | `/rewards` / `/wallet` (Tab 4)| Points balance, interactive scratch cards with coin bursts, discount store |
| **18** | **Profile & Settings** | `/profile` | Account hero card, personal UPI QR modal, security switches, debug toggle |

---

## Business Logic & Pricing Engine

All operational financial rules are strictly isolated in `lib/core/pricing_rules.dart`:

1. **Daily Transfer Cap**: Maximum ₹1,00,000 per rolling 24-hour day across bank accounts.
2. **Mindful PayPause Threshold**: Payments $\ge$ ₹2,000 activate the 3-second reflection pause.
3. **Credit Card Bill Settlement Fees**:
   - First 2 credit card settlements per calendar month: **₹0 (Free)**.
   - 3rd card settlement onward: **1.0% convenience fee**.
4. **Loan Eligibility & EMI**: Approved borrowing limit is calculated as $\text{Monthly Inflow} \times 2.5$ up to ₹2,50,000 at 11.5% APR.

---

## Design System & Theme Tokens

PayWise uses custom tokens defined in `lib/core/theme/`:

- **Primary Purple**: `#5B259F`
- **Primary Dark**: `#401375`
- **Primary Light**: `#8C4FE6`
- **Accent Green**: `#10B981`
- **Alert Orange**: `#F59E0B`
- **Danger Red**: `#EF4444`
- **Background Canvas**: `#F8F9FA`
- **Surface Containers**: `#FFFFFF`
- **Text Primary**: `#1E293B`
- **Text Secondary**: `#64748B`
- **Border Subdued**: `#E2E8F0`
- **Typography**: Google Fonts `Plus Jakarta Sans`
- **Icons**: 45 bespoke SVG line icons (zero emojis anywhere in the app)

---

## Project Structure & 150-Line Rule

Every single `.dart` file in `lib/` strictly adheres to a $\le$ 150 lines constraint for maximal readability:

```
lib/
├── main.dart                          // App entry point and Provider setup
├── firebase_options.dart              // Multi-platform Firebase configuration
├── core/
│   ├── pricing_rules.dart             // Pure Dart business calculations & tests
│   ├── categories.dart                // 8 spending categories, colors & SVG icons
│   ├── router.dart                    // GoRouter config with 5-tab StatefulShellRoute
│   ├── theme/
│   │   ├── app_colors.dart            // Palette constants
│   │   ├── app_theme.dart             // Complete Flutter ThemeData
│   │   └── app_typography.dart        // Plus Jakarta Sans typography scale
│   └── widgets/
│       ├── app_icon.dart              // SvgPicture icon renderer
│       └── app_button.dart            // Standard styled primary/outline buttons
├── data/
│   ├── app_provider.dart              // Central reactive state engine
│   ├── auth_service.dart              // Firebase Authentication gateway
│   ├── firestore_service.dart         // Cloud Firestore database streams
│   ├── demo_data.dart                 // Initial seeded fixtures
│   └── models/                        // 9 strongly-typed data models
└── features/
    ├── auth/                          // Screen 01 Login
    ├── home/                          // Screen 02 Home dashboard & nav shell
    ├── pay/                           // Screens 03, 04, 05, 07 (Scan, Contacts, Pay, Success)
    ├── paypause/                      // Screen 06 Mindful PayPause reflection sheet
    ├── history/                       // Screens 08, 09 (History, Donut chart, Detail sheet)
    ├── bills/                         // Screens 10, 11, 12 (Bills, Autopay, Credit card)
    ├── wealth/                        // Screens 13, 14 (Wealth dashboard, Digital gold)
    ├── insurance/                     // Screen 15 Insurance discovery & claim tracker
    ├── lending/                       // Screen 16 Micro-lending & EMI calculator
    ├── wallet/                        // Screen 17 Rewards, scratch cards & voucher store
    └── profile/                       // Screen 18 Profile, UPI QR modal & debug switches
```

---

## Setup & Execution Guide

### Prerequisites
- Flutter SDK (3.24 or later)
- Google Chrome (for web) or iOS Simulator / Android Emulator

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Automated Test Suite
```bash
flutter test
```
*Executes all 23 unit and widget tests covering pricing rules, history donut, bill categories, wealth allocations, rewards, and login.*

### 3. Static Code Analysis
```bash
flutter analyze
```
*Validates 0 lint issues and 0 type errors across the entire codebase.*

### 4. Run Locally
```bash
# Run on Web (Chrome)
flutter run -d chrome

# Run on macOS desktop
flutter run -d macos
```

### 5. Build & Deploy to Firebase Hosting
```bash
flutter build web --release
firebase deploy --only hosting
```

---

## Testing & Quality Assurance Summary

| Test Suite | File | Tests Passing | What Is Verified |
|---|---|---|---|
| **Pricing Rules** | `test/pricing_test.dart` | 9 | ₹1L limit, ₹2k PayPause, 1% card fee rule, EMI math |
| **History & Donut** | `test/history_test.dart` | 4 | Donut chart rendering, outflow total, month navigator |
| **Bills & Autopay** | `test/bills_test.dart` | 2 | 10 service categories grid, bill tile actions |
| **Wealth & Gold** | `test/wealth_test.dart` | 3 | Net worth toggle visibility, asset allocation bar |
| **Rewards & Lending** | `test/insurance_lending_rewards_test.dart` | 3 | Rewards points hero, voucher catalog disabled state |
| **Profile & QR** | `test/profile_polish_test.dart` | 2 | Profile hero KYC badge, QR modal display |
| **Widget Baseline** | `test/widget_test.dart` | 1 | Login screen with demo access button |
| **Total** | | **23 Passing** | **100% Green** |
