# CONTEXT: "PayWise" - a PhonePe-style UPI, Wealth and Services app (Flutter)

Read this whole file before doing anything. Follow it for the entire project.
If this file and your habits disagree, this file wins.

---

## 0. Who you are working for (most important)

- The owner is a **student who does not know Flutter or Dart**. They must be able to open any file, understand what it does, and explain it to a teacher.
- This is a college submission for a **Cross-Platform App Development (Flutter)** subject. The teacher will be shown 4 things: **documentation PDF, Figma file, source code on GitHub, deployed app**.
- The owner also needs **1 personal explanation PDF** so they can point at code and explain it confidently.
- Talk to the owner in **plain English**. No jargon without a one-line meaning. Never assume they know a term like "widget tree", "state", or "provider" until you have explained it once in `docs/MY_GUIDE.md`.
- **You do the work, not the owner.** Run commands, install tools, create files, connect services yourself (see section 0.5). Ask the owner only for things that truly need a human (a browser sign-in, a decision, an approval).

---

## 0.5 Autonomy: do everything yourself

The owner wants Antigravity to do all the work. The owner has **already added their Stitch API key** to the MCP setup.

**Install and set up anything you need, whenever you need it, without asking first:**
- Check `flutter doctor` once at the start. If Flutter, Dart, Node.js, Git, Chrome web support or Android tooling is missing, install or enable what is missing for the owner's operating system.
- Install CLIs: Firebase CLI, FlutterFire CLI, GitHub CLI (`gh`).
- Install and register MCP servers: the **Stitch MCP server** (use the key already configured; test it with one real call before doing anything else) and any other MCP you need.
- Install doc tools in `tools/` only (Node packages for code images and PDF building).
- Run `flutter create`, `flutter pub add` (approved packages only), `flutterfire configure`, `firebase init`, `firebase deploy`, `git`, and `gh` commands yourself.
- Use the IDE's browser agent to open the app, take screenshots, and click through Stitch and Firebase pages where possible.

**Pause and ask the owner ONLY for:**
1. **Browser sign-ins you cannot do** (Google/Firebase login, GitHub login, Figma login). Run the command, tell the owner "a browser window opened, sign in and say done" in one sentence, then continue.
2. **Approvals** at the end of each milestone and the design approval in M1.
3. **Anything that costs money**, deletes the owner's own files, or touches files outside this project folder.
4. **Adding a Flutter package outside the approved list** (section 4).

**Never tell the owner to run a command you could run.** If a command fails, read the error, fix it, and retry once. If it fails again for the same reason, explain it in two sentences and propose one fix.

Keep a short `docs/SETUP_LOG.md` listing what you installed and which command did it (one line each), so the owner can answer "how did you set this up?".

---

## 1. Case study (the source of truth)

**Product:** PhonePe-style UPI payments app with investments, insurance and lending, built in Flutter for consistent behaviour on Android, iOS and web.

**Must-have features (every one must be visible in the app):**

1. UPI payment with **QR scanner** and **amount entry**
2. **Contact list** with UPI ID mapping
3. **Transaction history** with category-wise spending
4. **Spending analysis pie chart** with category breakdown
5. **Bill payments** with reminders and autopay setup
6. **Investment dashboard**: mutual funds, gold, fixed deposits
7. **Insurance discovery** with policy recommendations, plus **claim tracking**
8. **Wallet balance** with add-money options
9. **Reward points balance** with redemption catalog
10. **Credit card bill payment** with due date alerts
11. **Gold** screen with current gold rate and holdings
12. **Lending** section with loan eligibility and offers

**Must show on screens:** transaction status, beneficiary details, payment success rate, cashback earned, reward point balance.

**Pricing rules (put ALL of these in one file: `lib/core/pricing_rules.dart`):**

| Item | Rule |
|---|---|
| UPI payments | Free |
| Transfer to bank | Free up to Rs 1,00,000 per day; above that, block with a clear message |
| Credit card bill payment | 2 free per calendar month, then 1% convenience fee |
| Digital gold | 0% making charge |

Show these rules to the user in the UI where relevant (for example "2 free payments left this month" on the card bill screen, "Rs 40,000 left today" on bank transfer).

---

## 2. Honest scope (do not fake anything silently)

- **No real money, no real NPCI/bank connection.** Payments are a realistic **simulation** that updates Firestore. Show a small, tasteful "Demo mode - no real money moves" label in Profile and on the splash screen.
- Gold rate, mutual fund values and FD rates are **simulated data** (a small local timer nudges the gold rate every few seconds so the screen feels alive). Label them "Simulated".
- Do not use the real PhonePe name, logo, or assets. The app is called **PayWise**. Purple branding is fine; it must be our own design.
- If something in the case study cannot be done honestly, tell the owner in one sentence and do the closest honest version.

---

## 3. The unique feature: PayPause (build this, make it shine)

**One-line pitch:** "Before you spend on something non-essential, PayWise shows what that payment does to your monthly budget, and gives you 5 seconds to rethink."

**How it works (keep the logic simple and in ONE file: `lib/features/paypause/paypause_logic.dart`):**

1. Each category has a monthly budget (stored on the user document, with sensible defaults).
2. When the user is about to confirm a payment in a **non-essential category** (Shopping, Food Delivery, Entertainment, Travel), compute `spentSoFar` and `projected = spentSoFar + amount`.
3. PayPause triggers if `amount >= Rs 2,000` **or** `projected > 80%` of that category's budget.
4. Show a bottom sheet with:
   - **Month Impact Ring**: an animated ring that fills from the current percent to the projected percent (turns amber over 80%, red over 100%).
   - A plain sentence: "This takes Food Delivery to 92% of your Rs 4,000 budget."
   - Two buttons: **"Skip this one"** and **"Pay anyway"**. "Pay anyway" is disabled for 5 seconds with a circular countdown drawn on the button. Skipping is always instant.
5. If the user skips, save a document in `users/{uid}/pauses` with `amount`, `category`, `createdAt`.
6. Home shows a card: **"Saved by pausing: Rs X across N payments"** (sum of the pauses collection).
7. A switch in Profile turns PayPause on or off (stored on the user document).

Write 2 small unit tests for this logic (trigger / no trigger). That is the only logic that needs tests besides pricing rules.

---

## 4. Tech decisions (fixed, do not change or add to them)

| Need | Choice | Why (plain English) |
|---|---|---|
| Language/framework | Flutter (stable) + Dart | Required by subject |
| Database + login | Firebase Auth + Cloud Firestore | Required by owner |
| Hosting | Firebase Hosting (Flutter **web** build) | Gives the teacher a live link |
| Version control | Git + GitHub | Required by owner |
| State handling | `provider` | Simplest option for beginners |
| Navigation | `go_router` | Standard, readable routes |
| Icons | **SVG files** via `flutter_svg` | No emojis, no icon fonts needed |
| Charts | `fl_chart` | Pie chart and ring |
| Animations | `flutter_animate` + Flutter built-in animation widgets | Short, readable animation code |
| Fonts | `google_fonts` (Plus Jakarta Sans) | Clean fintech look |
| Formatting | `intl` | Rupee and date formatting |
| QR scanner | `mobile_scanner` | Works on mobile and web (HTTPS) |

**Approved package list is exactly:** `firebase_core, firebase_auth, cloud_firestore, provider, go_router, flutter_svg, fl_chart, flutter_animate, google_fonts, intl, mobile_scanner`.
Do **not** add any other package without asking the owner first.

**Forbidden:** `build_runner`, `freezed`, `json_serializable`, `get_it`, `bloc`, `riverpod`, code generation of any kind, clean-architecture layers (no repositories + usecases + datasources + entities + mappers for one screen).

---

## 5. Code rules (read twice; this is how "AI slop" is prevented)

### 5.1 Write the smallest code that works
- If one line does the job, write one line. Do not wrap it in a helper, class, or 5 lines "for clarity".
- Create a new class, function or file **only when it is used in 3 or more places**, or when a file would pass 150 lines.
- Use Flutter's built-in widgets before writing custom ones (`ListTile`, `Card`, `Hero`, `AnimatedContainer`, `TweenAnimationBuilder`, `showModalBottomSheet`).
- Models are plain Dart classes with a `fromMap` and a `toMap`. No generated code.
- No speculative features, no "future-proofing", no config options nobody uses.

### 5.2 Never do these
- No commented-out code. No leftover TODOs. No unused imports or variables. No `print`.
- No empty `try/catch`. Catch an error only where you show the user a message.
- No defensive null checks "just in case". Check only where data really can be missing.
- No duplicate widgets: if two screens show a transaction row, there is one `TransactionTile`.
- No giant files. **Hard limits: file <= 150 lines, a single widget's `build` <= 60 lines.** Split by pulling a section into its own small widget file.
- No emojis anywhere: not in UI text, code, comments, commit messages, or docs. Use SVG icons.
- No hardcoded colors, font sizes or spacing inside screens. Use the tokens from `lib/core/theme/`.

### 5.3 Do not waste effort re-checking
- After writing a file, **do not re-read it** to "verify". Move on.
- Run `flutter analyze` **once at the end of each milestone**, fix what it reports, run it once more. That is the limit.
- Run the app **once per milestone** to confirm it starts and the new screen opens. Do not repeatedly rebuild for tiny tweaks; batch them.
- If something fails twice with the same cause, stop, explain the problem to the owner in two sentences, and propose one fix. Do not try five variations.
- Do not rewrite working code for style. Do not refactor between milestones unless something is broken or a file passes the size limit.

### 5.4 Make code readable for a beginner
- **Names are plain English**: `sendMoney`, `pendingBills`, `spendingByCategory`. Not `execTxnHndlr`.
- Above each non-obvious block, one comment line saying **what it does for the user**, for example `// Shows the green tick after payment succeeds`. Do not comment every line (line-by-line explanations live in the docs, not in the code).
- Every screen file is named after the screen: `pay_screen.dart`, `history_screen.dart`.
- Any Flutter concept used the first time gets a short beginner explanation in `docs/MY_GUIDE.md` (see section 11).

### 5.5 Folder structure (feature-first, flat, easy to find things)

```
paywise/
  lib/
    main.dart                      app start, Firebase start, theme, router
    firebase_options.dart          generated by FlutterFire CLI
    core/
      theme/                       colors.dart, text_styles.dart, app_theme.dart
      pricing_rules.dart           ALL fee/limit rules
      categories.dart              spending categories (name, icon, color)
      formatters.dart              rupee + date formatting (small)
      widgets/                     shared UI pieces (see 5.6)
      animations/                  reusable animations (see 7)
    data/
      models/                      transaction.dart, contact.dart, bill.dart, ...
      firestore_service.dart       the ONLY file that talks to Firestore
      demo_data.dart               fake data loaded on first login
    features/
      auth/                        login_screen.dart
      home/                        home_screen.dart + its small widgets
      pay/                         scan_screen.dart, contacts_screen.dart, pay_screen.dart, success_screen.dart
      paypause/                    paypause_logic.dart, paypause_sheet.dart
      history/                     history_screen.dart, spending_pie.dart
      bills/                       bills_screen.dart, autopay_sheet.dart, card_bill_screen.dart
      wealth/                      wealth_screen.dart, mutual_funds_screen.dart, gold_screen.dart, fd_screen.dart
      insurance/                   insurance_screen.dart, claim_tracker_screen.dart
      lending/                     lending_screen.dart
      wallet/                      wallet_screen.dart, rewards_screen.dart
      profile/                     profile_screen.dart
  assets/
    icons/                         SVG icons
    images/                        SVG illustrations (empty states, splash)
  design/
    stitch-prompts.md              prompts used to generate screens in Stitch
    stitch/                        approved Stitch screens (reference images + HTML)
    figma-spec.md                  backup design spec (tokens + screen list)
  docs/
    MY_GUIDE.md                    owner's personal explanation (-> PDF)
    PROJECT_DOCUMENTATION.md       teacher documentation (-> PDF)
    code-explained/                one .md per code file (-> PDF)
    screenshots/                   app screenshots, numbered
  tools/                           doc-building scripts (section 11)
  test/                            paypause_test.dart, pricing_test.dart
  firestore.rules
  firebase.json
  README.md
```

Rule: **one screen's pieces live next to that screen.** Only truly shared pieces go in `core/widgets`.

### 5.6 Shared widgets (build once, reuse everywhere)
`AppIcon` (wraps an SVG, takes name + size + color), `PrimaryButton`, `AmountText` (rupee formatting + count-up option), `TransactionTile`, `SectionHeader`, `StatusChip` (success / pending / failed), `EmptyState`, `ShimmerBox`, `BottomSheetShell`.

---

## 6. Design system

**Feel:** trustworthy, calm, premium fintech. Lots of white space, soft shadows, big confident numbers, one strong brand color.

**Color tokens (`colors.dart`):**
- `brand` #5F259F, `brandDark` #3F1670, `brandSoft` #F1E9FA
- `success` #1E9E5A, `warning` #E8A317, `danger` #D64545, `info` #2F6FDE
- Light: `background` #F7F6FB, `surface` #FFFFFF, `textPrimary` #1B1530, `textSecondary` #6B6780, `divider` #ECE9F3
- Dark (build it only if time remains after all milestones): matching tokens, same names
- Category colors: 8 distinct, accessible colors, defined once in `categories.dart`

**Type:** Plus Jakarta Sans. Scale: display 32, title 22, heading 18, body 15, caption 12. Numbers use tabular figures.
**Spacing:** 4-point grid (4, 8, 12, 16, 24, 32). **Radius:** 12 for cards, 16 for sheets, full for chips.
**Touch targets** at least 48 px. Text contrast must pass accessibility guidelines.
**Layout:** design for phone width 390 first; on web, center the app in a 430 px wide column on larger screens so it looks like a phone app.

**Icons - hard rule: SVG only, no emojis, no Material icon font.**
- Put every icon in `assets/icons/` as `name.svg`, 24x24 viewBox, 1.75 stroke, rounded caps, `currentColor` so one file works in any color.
- Use one consistent open-source set (Lucide or Tabler, both free for this use). Download them from the set's GitHub, or hand-write simple ones. Keep the license note in `README.md`.
- Needed icons (minimum): home, history, wealth, services, rewards, scan, send, receive, wallet, bank, contact, qr, bill, electricity, mobile, dth, card, gas, water, wifi, gold, chart, mutual-fund, fd, shield, heart-pulse, car, loan, gift, bell, autopay, check, close, alert, clock, chevron-right, search, user, settings, plus, arrow-up-right, arrow-down-left, pause, trophy, flash.
- Illustrations (empty states, splash, success) are simple SVG shapes in the brand palette.

---

## 7. Animations (purposeful, smooth 60 fps, short)

Keep every animation under 600 ms unless stated. Build each as a **small reusable widget in `core/animations/`**, not repeated code.

1. **Payment success tick**: circle grows, tick draws itself (a `CustomPainter` path animation), brief ripple, then amount and cashback slide up.
2. **Count-up numbers** for wallet balance, reward points, cashback (`TweenAnimationBuilder`).
3. **Pie chart sweep-in** when the history analysis opens; tapping a slice pops it out and shows its amount in the center.
4. **Staggered list entrance** for transaction and bill lists (`flutter_animate` `.animate().fadeIn().slideY()` with an interval).
5. **Hero transition** of contact avatar from contacts list to the pay screen.
6. **Press feedback**: buttons scale to 0.97 on press.
7. **Shimmer** placeholders while Firestore data loads.
8. **QR scanner**: a scan line moving up and down inside a corner-bracket frame.
9. **PayPause ring fill** and button countdown ring (section 3).
10. **Gold rate ticker**: price flips color green/red briefly when it changes.
11. **Claim tracker**: the progress line fills step by step.

Page transitions: one consistent fade-through or slide, set once in `go_router`. Respect "reduce motion" (skip animations if the system asks).

---

## 8. Screens and behaviour (build in this order)

Bottom navigation (5 tabs): **Home, History, Wealth, Services, Rewards**. A raised center **Scan** button opens the scanner.

**Home**
- Header: greeting, wallet balance chip (tap opens Wallet), bell.
- Quick actions: Scan QR, Pay Contact, Pay UPI ID, To Bank, Mobile Recharge.
- Stat cards: **Payment success rate** (success / total, as a percent with a small ring), **Cashback earned** (this month), **Reward points**.
- PayPause card: "Saved by pausing".
- Recent transactions (5) with status chips.
- Bills due soon strip.

**Pay flow**
1. **Scan**: camera scanner with frame + scan line; reads a UPI QR (`upi://pay?pa=...&pn=...&am=...`). A "Demo QR" button simulates a scan (laptops may lack cameras). A "Enter UPI ID" fallback sits below.
2. **Contacts**: searchable list; each row shows name, **UPI ID**, bank. Tap opens **beneficiary details** (name, UPI ID, bank, last 3 payments to them).
3. **Pay screen**: big amount entry with a custom number pad, note field, category chip (auto-suggested, editable), balance shown, bank transfer limit shown when relevant.
4. If PayPause triggers, show it **before** the final confirm.
5. **Processing** (about 1.2 s shimmer/progress) then **Success or Failure screen**. Most payments succeed; allow a demo "Simulate failure" toggle in Profile so the success rate and failed status are demonstrable.
6. On success: write transaction, update wallet or balance, add cashback (small rule: 1% up to Rs 20) and reward points (1 point per Rs 10).

**History**
- Top: month switcher, total spent, **pie chart by category** with legend (amount + percent).
- Below: transaction list grouped by day, filter chips (All, Sent, Received, Failed), tap a row for a detail sheet with **status timeline** (initiated, bank processing, completed), beneficiary details, reference ID, cashback.

**Services**
- **Bills**: grid of categories (Electricity, Mobile, DTH, Gas, Water, Broadband). Saved bills list with due date, amount, **reminder** (days before) and **autopay** toggle opening an `autopay_sheet` (max amount per bill, payment date).
- **Credit card bill**: cards list with due amount and due date, **due date alerts** (a banner when due within 5 days), pay button applies the pricing rule (2 free, then 1% fee, shown before paying).
- **Insurance**: recommended policies (Health, Term, Motor, Travel) with simple "why recommended" using the user's profile (age, dependents, vehicle); tap shows cover, premium, key points; "Buy" creates an active policy (demo). **Claim tracker**: pick an active policy, raise a claim, see steps Submitted, Under review, Approved, Paid with an animated progress line.
- **Lending**: user enters monthly income and the app computes eligibility with a plain rule (for example up to 10x monthly income, reduced if existing EMIs); shows 3 loan offers (personal, instant credit line, gold loan) with interest, tenure, EMI computed live by a slider.

**Wealth**
- Dashboard: total portfolio value, invested vs current, gain/loss percent, small allocation donut.
- **Mutual funds**: 4-5 simulated funds with 1Y/3Y returns, holdings list, "Start SIP" demo.
- **Gold**: current rate per gram (simulated, ticking), holdings in grams and value, buy/sell sheet, **0% making charge** badge.
- **Fixed deposits**: rates by tenure, a calculator showing maturity amount, "Open FD" demo.

**Rewards**
- Reward points balance (count-up), earning history, **redemption catalog** (vouchers, cashback to wallet, gold grams) as cards with point cost; redeem deducts points and records it; unaffordable items are visibly disabled.

**Wallet** (opened from Home)
- Balance, **add money** options (UPI, debit card, net banking as option cards, demo only), wallet transaction list.

**Profile**: name, UPI ID, PayPause switch, demo-failure switch, "Reload demo data", sign out, "Demo mode" note.

**Login**: simple, beautiful. Email + password and a **"Continue as demo user"** button (anonymous sign-in). On first login, `demo_data.dart` fills Firestore with: 8 contacts, ~40 transactions over 2 months across categories, 5 bills, 2 cards, holdings, 3 recommended policies, 1 active policy, reward points and wallet balance.

---

## 9. Firebase

**Collections (keep this exact shape; document it in the docs):**

```
users/{uid}                  name, upiId, walletBalance, rewardPoints, cashbackTotal,
                             goldGrams, paypauseOn, monthlyBudgets {category: amount},
                             profile {age, dependents, hasVehicle}
users/{uid}/transactions     amount, direction (sent/received), status, category,
                             counterpartyName, counterpartyUpi, note, cashback, fee, createdAt
users/{uid}/contacts         name, upiId, bank
users/{uid}/bills            provider, category, amount, dueDate, autopay, autopayMax, reminderDays
users/{uid}/cards            bank, last4, dueAmount, dueDate
users/{uid}/investments      type (mf/fd), name, invested, currentValue
users/{uid}/policies         name, type, insurer, premium, cover, status (recommended/active)
users/{uid}/claims           policyId, step, updatedAt
users/{uid}/pauses           amount, category, createdAt
```

**Security rules (`firestore.rules`):** a signed-in user can read and write only documents under their own `users/{uid}`. Nothing else is accessible.

**Code rule:** only `firestore_service.dart` imports `cloud_firestore`. Screens ask it for data through `provider`. Use Firestore streams so screens update live.

**Setup (you run all of this; the owner only signs in when a browser opens):**
1. `firebase login` (owner signs in once in the browser). Create the project with `firebase projects:create` (free Spark plan, no billing) or reuse one the owner names.
2. Enable Email/Password and Anonymous sign-in and create the Firestore database. Use the CLI where possible; otherwise drive the Firebase console with the browser agent and fall back to giving the owner exact clicks.
3. `dart pub global activate flutterfire_cli`, then `flutterfire configure` to generate `firebase_options.dart`.
4. `firebase init hosting` (public dir `build/web`, single-page app: yes) and deploy `firestore.rules` with `firebase deploy --only firestore:rules`.
5. Deploy the app: `flutter build web --release` then `firebase deploy --only hosting`. Save the live URL in `README.md`.
Explain each command in one plain sentence in `docs/SETUP_LOG.md` and `docs/MY_GUIDE.md`.

---

## 10. Git and GitHub

- `git init` at the start, a proper Flutter `.gitignore`, and a real `README.md` (what the app is, screenshots, live link, how to run, folder map, Figma link).
- Branch `main` stays working. Make one short branch per milestone (`feature/m3-pay-flow`), merge when the milestone is approved.
- **Commit at the end of each milestone**, message in plain English, present tense, no emojis: `Add pay flow with QR scanner and success animation`.
- Run `gh auth login` (owner signs in once in the browser), then create the repo yourself with `gh repo create paywise --public --source=. --remote=origin --push`. Push after every merge.
- Never commit service account keys or private files. (`firebase_options.dart` is fine to commit; the Firestore rules protect the data.)

---

## 11. Figma and documentation deliverables

### 11.1 UI design: Google Stitch (designs the screens) then Figma (one-click export)
The owner does NOT want to draw screens by hand, and the Figma MCP does not work reliably from Antigravity (it is read-only there). So the design flow is:

**Stitch designs the screens -> you export them to Figma -> you build the same screens in Flutter.**

**Setup (already mostly done by the owner):**
1. The owner has **already added the Stitch API key**. Do not ask for it again.
2. Install or register the Stitch MCP server in Antigravity yourself (search "Stitch" in the MCP store, or add it with the config Stitch's Exports panel shows). Test it with one real call (a single login screen). Setup steps change, so follow what Stitch's panel shows today.
3. If the tools still do not appear after one fix attempt, tell the owner in two sentences, then fall back to writing the prompts and driving the Stitch website with the browser agent.

**What you do in M1 (design first, before app code):**
- Write `design/stitch-prompts.md`: one **design-system prompt** (tokens from section 6, Plus Jakarta Sans, purple brand, 390 px phone screens, "no emojis, simple line icons only", "this is a fintech app called PayWise") and one **short prompt per screen** (from section 8, including the PayPause sheet, success screen and status timeline).
- Using the Stitch MCP, generate the screens in batches by feature group (Auth+Home, Pay, History, Services, Wealth, Rewards+Wallet). Keep every screen in **one Stitch project**, so the style stays consistent. Make one fix pass at most per group, only for clear problems (wrong colors, overflowing text).
- Ask the owner to review in Stitch and say "approved".
- Save a screenshot and the HTML of each approved screen in `design/stitch/` named like the Flutter screens (`home_screen.png`).

**Figma export:** After approval, use the browser agent to run Stitch's **Export to Figma** (editable frames with auto layout). If Figma asks for a sign-in, ask the owner to sign in and say done, then finish the export. Save the Figma link in `README.md`. If the export misbehaves, the fallback is to import the Stitch screenshots into Figma as frames. Say so honestly if the frames are images instead of editable layers.

**Important: Stitch makes web HTML/CSS, not Flutter.** Never paste its HTML into the app. Use the Stitch screens only as a **visual reference** (layout, spacing, hierarchy, colors) and rebuild each screen with Flutter widgets, our design tokens, and our SVG icons. Stitch may use font icons or emojis: replace those with our SVG icons. If Stitch's design conflicts with a rule in this file (file size, no emojis, SVG icons), this file wins.

**Efficiency rules for design work:** generate a screen once, do not regenerate it to explore alternatives unless the owner asks, do not re-fetch a screen you already saved, and do not fine-tune pixels in Stitch. Free usage has monthly limits, so avoid wasted generations.

Also write a short `design/figma-spec.md` in M1 (tokens and screen list only) as the backup plan.

### 11.2 Teacher documentation: `docs/PROJECT_DOCUMENTATION.md` -> PDF
Clean, short sentences, simple words. Contents:
1. What the app is and the problem it solves (from the case study)
2. **Requirement checklist table**: each case study feature -> screen -> file -> screenshot number
3. The unique feature PayPause, with screenshots and a simple flow diagram
4. Pricing rules and where they are enforced
5. Screen-by-screen walkthrough with a **screenshot of every screen** and 3-5 lines on what the user can do
6. Folder structure explained in plain words
7. Firebase: collections table, security rules in plain words, deployment steps
8. Tech stack table (what and why)
9. Links: GitHub, Figma, live app
10. Limitations (demo mode, simulated data)

### 11.3 Code explanation PDF: `docs/code-explained/` -> `CODE_EXPLAINED.pdf`
This is the "explain every line" document. Rules:
- **One markdown file per code file**, in the same order as the app flow.
- Each file starts with: **What this file does** (2 sentences, no jargon) and **Where you see it in the app** (with the screenshot).
- Then the code in small chunks (5-15 lines). Under each chunk a table: `Line | Code | What it means in simple words`. **Every line gets an explanation**; repeated trivial lines (closing brackets) may be grouped as "ends the X above".
- Use everyday comparisons ("a Widget is like a Lego block; a screen is many blocks stacked").
- **Screenshots required:** for each chunk, include an image of the code (rendered by the script below) and, where it creates something visible, a screenshot of that part of the app with the area highlighted.
- Because every line must be explained, the small-file rule in section 5 is what keeps this document finishable. Do not write long code.

### 11.4 Owner's personal guide: `docs/MY_GUIDE.md` -> `MY_GUIDE.pdf`
Written for someone new to Flutter. Contents:
1. Flutter in 10 minutes: widget, screen, state, `build`, `Scaffold`, `Column/Row`, `ListView`, `Provider`, `async/await`, Firestore stream, in everyday language
2. "How the app starts": `main.dart` walkthrough
3. **Pointer table: "If someone asks me about X, I open file Y, lines A-B"** for every case study feature and for PayPause
4. How data flows (tap Pay -> what runs -> where it is saved -> what refreshes), as a simple diagram
5. **Viva cheat sheet**: 25 likely teacher questions with short, honest answers (why Flutter, why Firebase, why `provider`, how QR scanning works, what is simulated, what PayPause does, how pricing rules are enforced, how deployment works)
6. How to run, build and deploy the project themselves
7. A glossary of every term used

### 11.5 Screenshots and PDF building
- Run the app in the browser at phone size (390 x 844) and capture screenshots with the IDE's browser agent or Chrome DevTools. Save as `docs/screenshots/01-login.png`, `02-home.png`, and so on, in app-flow order. Use the demo data so screens are full, not empty.
- Create `tools/build_docs.js` (Node): renders code chunks to PNG images (highlighted, with line numbers) and converts the three markdown documents into PDFs with images embedded. Keep the script under 150 lines. Output: `docs/PROJECT_DOCUMENTATION.pdf`, `docs/CODE_EXPLAINED.pdf`, `docs/MY_GUIDE.pdf`. Tool dependencies go in `tools/package.json` only, not in the Flutter project.
- Write the docs **at the end of each milestone for that milestone's files**, so they never pile up. Final milestone only assembles the PDFs.

---

## 12. Milestones (stop and report after each one)

After each milestone: run analyze once, run the app once, commit, push, then reply in **5 lines max**: what was built, what to look at on screen, anything the owner must do. **Wait for the owner's "continue".**

| # | Milestone | Done when |
|---|---|---|
| M0 | Project + Git + folders + packages + this rules check | App runs a blank themed screen, repo pushed |
| M1 | Design system, SVG icons, shared widgets, nav shell, Stitch connected, all screens designed in Stitch and approved, exported to Figma, `figma-spec.md` | 5 empty tabs navigate smoothly; Figma file has every screen |
| M2 | Firebase connected, Auth, Firestore service, demo data, rules | Demo login works, data visible in Firestore console |
| M3 | Home, Contacts, Scanner, Pay flow, Success animation, **PayPause** | A full payment works end to end and updates history |
| M4 | History and spending pie chart, transaction detail with status timeline | Pie matches the transaction list |
| M5 | Bills, autopay, reminders, credit card bill with fee rule and alerts | 3rd card payment in a month shows the 1% fee |
| M6 | Wealth: mutual funds, gold with live rate, FD | Gold buy changes holdings and wallet |
| M7 | Insurance + claim tracker, Lending, Wallet, Rewards redemption | Redeeming reduces points; loan EMI slider works |
| M8 | Polish pass, empty/error states, web layout, deploy to Firebase Hosting | Live URL works on phone and laptop |
| M9 | Screenshots, three PDFs, README final, Figma and Stitch design links added | PDFs open cleanly with images |

**Polish pass (M8) checklist, done once:** no text overflow on small phones, loading and empty states everywhere, no hardcoded colors left, `flutter analyze` clean, app icon and web title set, animations respect reduce-motion.

---

## 13. How to talk to the owner

- Short and plain. No filler, no repeating what you already said.
- You run commands yourself. When you run something important (install, deploy, push), say in one plain sentence what it does.
- If you must choose between two approaches, pick the simpler one and say so in one line; ask a question only if the answer truly changes the result, and ask one at a time.
- Never claim something works without having run it. If you could not run it, say so.
- Never invent features, data sources or package behavior. If unsure, say "I am not sure" and check the official docs.

---

## 14. Final definition of done

- All 12 case study features visible and working with demo data
- PayPause working with the Month Impact Ring, countdown, and "Saved by pausing" card
- Pricing rules enforced and shown in the UI
- SVG icons only, zero emojis anywhere
- Every code file is under 150 lines, with plain names and short comments
- `flutter analyze` is clean, 2 test files pass
- App deployed on Firebase Hosting, code on GitHub, every screen designed in Google Stitch and exported to Figma, and the Flutter screens match those designs
- Three PDFs exist: `PROJECT_DOCUMENTATION.pdf` (teacher), `CODE_EXPLAINED.pdf` (teacher, every line explained, with screenshots), `MY_GUIDE.pdf` (owner)