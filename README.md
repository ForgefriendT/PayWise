# PayWise

A modern PhonePe-style UPI, wealth, and services application built with Flutter, Firebase, and Provider.

## Overview
PayWise is a comprehensive fintech simulation app featuring UPI payments, spending analytics, bill payments, digital gold, mutual funds, insurance, lending, and an intelligent budgeting safety feature called **PayPause**.

## Features
- UPI payments with QR scanner, contacts, and custom amount keypad
- PayPause budgeting guard: 5-second rethink buffer for non-essential spending
- Spending analysis pie chart with category breakdown
- Bill payments with autopay and reminders
- Wealth dashboard: simulated digital gold with live ticker, mutual funds, and fixed deposits
- Insurance discovery with claim tracker
- Wallet and reward points redemption catalog
- Simulated transaction success/failure toggle in Profile

## Tech Stack
- **Framework**: Flutter (Dart)
- **Backend & Database**: Firebase Auth, Cloud Firestore
- **Hosting**: Firebase Hosting (Web)
- **State Management**: Provider
- **Routing**: GoRouter
- **Icons**: Custom SVG icons via flutter_svg (no emojis)
- **Charts**: fl_chart
- **Animations**: flutter_animate and native implicit animations
- **Typography**: Plus Jakarta Sans (Google Fonts)

## Folder Structure
```
paywise/
  lib/
    main.dart                  App entry point, theme, router
    firebase_options.dart      Generated Firebase configuration
    core/
      theme/                   Colors, text styles, app theme
      pricing_rules.dart       Pricing and fee logic
      categories.dart          Spending categories definition
      formatters.dart          Rupee and date formatters
      widgets/                 Shared reusable UI components
      animations/              Reusable animation components
    data/
      models/                  Data models
      firestore_service.dart   Single Firestore gateway
      demo_data.dart           Initial mock data
    features/
      auth/                    Authentication screens
      home/                    Dashboard and quick actions
      pay/                     Scan, contacts, payment, success screens
      paypause/                PayPause logic and bottom sheet
      history/                 Transactions and spending pie chart
      bills/                   Utility and credit card bills
      wealth/                  Mutual funds, gold, fixed deposits
      insurance/               Policy discovery and claim tracker
      lending/                 Loan eligibility and EMI calculator
      wallet/                  Wallet balance and top-up
      profile/                 Settings and demo switches
  assets/
    icons/                     SVG icons
    images/                    SVG illustrations
  design/
    stitch-prompts.md          Stitch prompts for screen design
    stitch/                    Reference screens
    figma-spec.md              Design token specifications
  docs/
    MY_GUIDE.md                Student explanation guide
    PROJECT_DOCUMENTATION.md   Teacher project documentation
    code-explained/            File-by-file code explanation
    screenshots/               App walkthrough screenshots
  tools/                       Documentation generation scripts
  test/                        Unit and widget tests
```

## Running Locally
```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome
```

## Links
- **GitHub Repository**: https://github.com/ForgefriendT/PayWise
- **Figma Design**: Pending export
- **Live Web App**: https://paywise-ae977.web.app

## Icon Attribution
Icons are based on open-source Lucide/Tabler icon sets under MIT license.
