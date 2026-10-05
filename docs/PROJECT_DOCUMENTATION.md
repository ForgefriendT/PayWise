# PayWise: Mindful UPI & Wealth Ecosystem
## Comprehensive Project Documentation

---

### Executive Summary

**PayWise** is a production-grade, PhonePe-inspired fintech application built with **Flutter 3 (Web & Mobile)** and powered by **Firebase** (Authentication & Cloud Firestore). Designed around the ethos of *mindful financial management*, PayWise blends rapid UPI payments, automated bill settlements, intelligent debt management, physical-backed digital wealth, personalized insurance coverage, instant micro-lending, and gamified cashback rewards into a coherent, ultra-clean mobile-first experience.

---

### 1. System Architecture & Tech Stack

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

#### Core Technology Stack:
- **Framework**: Flutter 3.24+ (Channel Stable)
- **Language**: Dart 3.5+
- **Navigation**: `go_router: ^14.6.2` (StatefulShellRoute with 5 indexed branches)
- **State Management**: `provider: ^6.1.2` (`ChangeNotifier` & reactive streams)
- **Database & Auth**: `firebase_core: ^3.8.0`, `cloud_firestore: ^5.5.0`, `firebase_auth: ^5.3.3`
- **Charts & Data Visualization**: `fl_chart: ^0.69.2` (Interactive Donut spending breakdown)
- **Vector Graphics**: `flutter_svg: ^2.0.16` (45 bespoke line icons, zero emojis)
- **Typography**: Google Fonts `Plus Jakarta Sans`
- **Testing**: `flutter_test` (23 automated unit and widget test cases)

---

### 2. Design System & Theme Tokens

PayWise adheres to an exact mathematical design token system defined in `lib/core/theme/`:

| Token Category | Token Constant | Hex Value | Purpose & Usage |
|---|---|---|---|
| Primary Color | `AppColors.primary` | `#5B259F` | PhonePe signature deep royal purple |
| Primary Dark | `AppColors.primaryDark` | `#401375` | Hero gradient end, active tap states |
| Primary Light | `AppColors.primaryLight` | `#8C4FE6` | Highlights, active chips, icon backgrounds |
| Accent Green | `AppColors.accentGreen` | `#10B981` | Success states, credit inflows, savings badges |
| Alert Orange | `AppColors.alertOrange` | `#F59E0B` | PayPause mindful friction, cautionary alerts |
| Danger Red | `AppColors.dangerRed` | `#EF4444` | High budget exceedances, transaction failures |
| Background Neutral | `AppColors.bgNeutral` | `#F8F9FA` | Page canvas background |
| Surface Pure | `AppColors.surfaceWhite` | `#FFFFFF` | Card containers, bottom sheets, dialogues |
| Text Primary | `AppColors.textPrimary` | `#1E293B` | High-contrast body copy and headings |
| Text Secondary | `AppColors.textSecondary`| `#64748B` | Subtitles, helper text, timestamps |
| Border Subdued | `AppColors.borderSubdued` | `#E2E8F0`| Divider lines, outline stroke (1px) |

---

### 3. Business Logic & Pricing Engine

All operational financial rules are strictly isolated in `lib/core/pricing_rules.dart`:

1. **Daily Bank Transfer Cap**:
   - Limit: **₹1,00,000 per rolling 24-hour day**.
   - Rule: Transfers above ₹1,00,000 are rejected immediately with descriptive guidance.
2. **Mindful PayPause Threshold**:
   - Soft Friction: **₹2,000**.
   - Rule: Payments of ₹2,000 or greater trigger an intentional pause bottom sheet displaying balance impact, recent category spending, and a 3-second reflection timer before confirmation.
3. **Credit Card Bill Processing Fees**:
   - First 2 card bill settlements per calendar month: **₹0.00 (Free)**.
   - Subsequent settlements (3rd card onward): **1.0% convenience fee**.
4. **Loan Eligibility Multiplier**:
   - Formula: Approved Limit = $\text{Monthly Inflow} \times 2.5$.
   - Max Cap: ₹2,50,000 at a competitive 11.5% APR.
5. **Gold Investment Rate**:
   - Real-time ticking 24K 99.9% pure gold price simulated with $\pm 0.1\%$ market variance.
   - Live buy and sell spreads with instant locker updates.

---

### 4. Firestore Database Architecture (9 Collections)

| Collection Name | Key Attributes | Description |
|---|---|---|
| `users` | `name`, `phone`, `email`, `upiId`, `walletBalance`, `kycStatus` | Core user identity & live wallet balance |
| `transactions` | `amount`, `type`, `counterparty`, `category`, `timestamp`, `status`, `referenceId` | Audit-trailed payment ledger entries |
| `contacts` | `name`, `phone`, `upiId`, `avatarUrl`, `isFavorite`, `lastSentAmount` | Frequent recipients and phone directory |
| `bills` | `billerName`, `category`, `amountDue`, `dueDate`, `autopayEnabled`, `scheduleType` | Utility, mobile, and broadband subscriptions |
| `credit_cards` | `bankName`, `cardNumberMasked`, `totalDue`, `minDue`, `dueDate`, `freeBillsUsed` | Linked credit cards and payment fee counters |
| `portfolio` | `totalValue`, `dailyReturnRate`, `goldGrams`, `mutualFundsValue`, `stocksValue` | Wealth holdings and asset distribution |
| `insurance_policies`| `title`, `type`, `provider`, `coverageAmount`, `premiumAmount`, `status` | Active health, vehicle, and life coverage |
| `loans` | `type`, `principal`, `interestRate`, `tenureMonths`, `emiAmount`, `status` | Pre-approved credit lines and active loans |
| `rewards` | `rewardPoints`, `cashbackTotal`, `scratchCardsAvailable`, `activeVouchers` | Gamified rewards and redeemable catalog items |

---

### 5. Detailed Screen Matrix (All 18 Stitch Screens)

1. **Screen 01 - Login**: Multi-method auth (Phone/Email) + "Continue as demo user" instant sign-in.
2. **Screen 02 - Home Dashboard**: Greeting, live wallet balance, 4 quick actions, 8 utility shortcuts, recent activity.
3. **Screen 03 - QR Scanner**: Live camera viewfinder overlay, flashlight toggle, gallery picker, manual UPI entry.
4. **Screen 04 - Contacts & Beneficiaries**: Search filter, frequent contacts carousel, full directory with tap-to-pay.
5. **Screen 05 - Pay & Numpad**: Custom responsive numpad, bank selector, note input, instant send action.
6. **Screen 06 - PayPause Sheet**: Visual friction sheet for large payments (>₹2,000) showing balance impact & 3s timer.
7. **Screen 07 - Payment Success**: Checkmark animation, transaction summary, sound haptics, share and receipt actions.
8. **Screen 08 - History & Spending Analysis**: FlChart interactive donut, monthly filter, outflow summary, category list.
9. **Screen 09 - Transaction Audit Sheet**: Detailed breakdown, reference ID, UTR number, repeat and dispute buttons.
10. **Screen 10 - Bills & Recharges Hub**: Grid of 10 utility categories, upcoming reminders, autopay status chips.
11. **Screen 11 - Autopay Setup Sheet**: Schedule selector (Instant, 3-day notice, Salary-linked) and monthly limit cap.
12. **Screen 12 - Credit Card Bill**: Card carousel, statement due dates, minimum vs custom pay, 1% fee calculation.
13. **Screen 13 - Wealth Dashboard**: Total portfolio net worth, returns graph, asset allocation bar, SIP shortcuts.
14. **Screen 14 - Digital Gold**: Live ticking 24K price, buy in rupees or grams, digital locker holding summary.
15. **Screen 15 - Insurance & Claims**: Health, auto, term life policy discovery cards and 4-stage live claim tracker.
16. **Screen 16 - Lending & EMI Calculator**: Instant eligibility slider (up to ₹2,50,000), tenure picker, live EMI math.
17. **Screen 17 - Rewards & Wallet**: Points balance, scratch cards with coin bursts, catalog voucher redemption.
18. **Screen 18 - Profile & Settings**: KYC badge, QR code generator modal, linked banks, security toggles, logout.
