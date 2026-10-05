# PayWise Stitch Generation Prompts

## 1. Global Design System Prompt
Create a modern, premium mobile fintech app called "PayWise" with 390px mobile viewport width.
Theme & Colors:
- Primary brand color: #5F259F (deep royal purple), brand dark: #3F1670, brand soft: #F1E9FA.
- Background: #F7F6FB (very soft grey-purple canvas), cards/surface: #FFFFFF.
- Typography: Plus Jakarta Sans for all headlines, labels, and numbers.
- Text: Primary #1B1530, Secondary #6B6780, Divider #ECE9F3.
- Semantic: Success #1E9E5A, Warning #E8A317, Danger #D64545, Info #2F6FDE.
- Aesthetics: Clean whitespace, 12px rounded cards, 16px bottom sheet radius, subtle ambient drop shadows (10% on_surface blur).
- Constraints: NO emojis anywhere; use crisp minimalist 1.75px stroke monochrome line icons only. Bold numbers with rupee symbol (₹).

---

## 2. Screen-by-Screen Prompts

### Group A: Auth & Home
- **Screen 01: Login Screen**
  "PayWise mobile fintech login screen. Top purple brand mark and title 'PayWise'. Subtitle 'Smart, calm payments'. Clean email and password text fields with floating labels. Primary purple button 'Sign In'. Divider with 'or'. Prominent secondary outline button 'Continue as demo user' with a subtle key icon. Bottom note 'Demo mode - simulated fintech platform'."

- **Screen 02: Home Screen**
  "PayWise fintech mobile home screen (390px). Top bar with greeting 'Hi, Fauzan', small pill chip showing '₹14,500' wallet balance, and notification bell icon. Quick action grid: Scan QR (highlighted purple circle), Send Money, UPI ID, Bank Transfer, Mobile Recharge. Stat cards row: 'Success Rate 98.4%' with mini progress ring, '₹240 Cashback this month', '1,250 Reward Points'. PayPause banner: 'Saved by pausing: ₹4,200 across 3 payments'. Recent 5 transactions list with status chips (Completed, Processing). Floating scan button at center of bottom navigation bar."

### Group B: Pay Flow & PayPause
- **Screen 03: QR Scanner Screen**
  "PayWise mobile QR scanner screen. Dark camera viewfinder background with rounded corner framing brackets and a central horizontal neon purple scan line. Top bar with back arrow and flashlight toggle. Bottom floating pill button 'Simulate Demo QR Scan' and text link 'Or enter UPI ID / Mobile number manually'."

- **Screen 04: Contacts & Beneficiaries Screen**
  "PayWise contacts list for UPI transfer. Top search bar 'Search name, mobile or UPI ID'. Section 'Recent Beneficiaries' with circular avatar initials, recipient name, UPI ID (e.g. rahul@oksbi), and bank logo badge. Tapping opens beneficiary card showing last 3 transaction history rows and 'Pay Now' button."

- **Screen 05: Pay Screen**
  "PayWise transfer amount entry screen. Header showing recipient avatar, name 'Priya Sharma', UPI ID 'priya@okhdfcbank'. Massive center amount display '₹ 2,500' with cursor. Horizontal category chips: 'Shopping (Selected)', 'Food', 'Entertainment', 'Bills'. Balance label 'Available in Wallet: ₹14,500'. Clean custom numeric keypad (1-9, ., 0, backspace). Bottom button 'Proceed to Pay ₹2,500'."

- **Screen 06: PayPause Bottom Sheet**
  "PayWise PayPause budgeting intervention bottom sheet. Title 'Take a 5-second PayPause'. Large circular Month Impact Ring graphic showing Food budget filling from 65% to 92% (amber alert color). Plain callout: 'This ₹2,500 payment takes Food Delivery to 92% of your monthly ₹4,000 budget'. Secondary button 'Skip this one (save ₹2,500)'. Primary button 'Pay anyway' disabled with an animated 5-second circular countdown timer."

- **Screen 07: Payment Success Screen**
  "PayWise payment success celebration screen. Center animated large green circle with crisp white checkmark path. Big bold text '₹2,500 Paid Successfully' to Priya Sharma. Reference UTR 'UPI/409218204921'. Cashback reward card: '₹25 Cashback added to wallet' with coin icon. '250 Reward Points earned'. Bottom primary button 'Done' and text button 'Share receipt'."

### Group C: History & Analytics
- **Screen 08: History & Spending Analysis Screen**
  "PayWise transaction history screen. Top month switcher ('October 2026') and total spent '₹32,450'. Prominent category spending pie chart with interactive segment popup and central total display. Category legend grid with color dots, percentage, and amount. Filter chips: 'All', 'Sent', 'Received', 'Failed'. Grouped daily transaction rows with category icons, recipient/sender, timestamp, and signed amounts (-₹450 in dark, +₹1,200 in green)."

- **Screen 09: Transaction Detail Sheet**
  "PayWise transaction details bottom sheet. Header with recipient, amount '₹1,850', and green 'Payment Successful' chip. Vertical 3-step status timeline: 'Payment Initiated (10:15 AM)', 'Bank Processing (HDFC Bank - 10:15 AM)', 'Completed & Credited (10:15 AM)'. Card details: UPI Ref ID, Beneficiary UPI, Debited Account (SBI ..4019), and Cashback Earned '₹18'."

### Group D: Services & Bills
- **Screen 10: Bills & Recharges Screen**
  "PayWise utility bill payment dashboard. Top grid of 6 utility icons: Electricity, Mobile Prepaid, DTH, Piped Gas, Water, Broadband. Section 'Saved Bills Due Soon': 2 cards showing 'BESCOM Electricity - ₹1,420 due in 3 days' with amber alert chip, and 'Airtel Broadband - ₹999'. Each card has 'Pay Now' button and 'Autopay: Off' switch."

- **Screen 11: Autopay Setup Bottom Sheet**
  "PayWise autopay configuration sheet. Title 'Set up Autopay for BESCOM Electricity'. Input field 'Maximum payment limit (₹)' with default '₹2,500'. Radio selector for payment schedule: 'On due date' or '2 days before due date'. Bank account selector. Plain explanation: 'We will automatically pay bills below your limit and notify you'. Primary button 'Confirm Autopay'."

- **Screen 12: Credit Card Bill Screen**
  "PayWise credit card bill management. Horizontal card stack showing HDFC Regalia and ICICI Coral cards with masked numbers, due date alert banner 'Due in 4 days!', and outstanding amounts. Fee policy notice: 'Pricing rule: 2 free card payments remaining this calendar month (1% fee applies afterwards)'. Pay button 'Pay Total ₹14,200'."

### Group E: Wealth, Insurance & Lending
- **Screen 13: Wealth Dashboard**
  "PayWise investment portfolio dashboard. Portfolio overview card: 'Total Value ₹1,24,500', 'Invested ₹1,10,000', green badge '+13.18% Gain'. Mini allocation donut chart (Mutual Funds 60%, Digital Gold 25%, Fixed Deposits 15%). 3 product cards: Mutual Funds with top performer 'Nifty 50 Index 1Y: +18.4%', Digital Gold with live ticking rate '₹7,420/g', and Fixed Deposits 'Up to 7.8% p.a.'."

- **Screen 14: Digital Gold Screen**
  "PayWise digital 24K 99.9% pure gold screen. Live ticker bar: '₹7,425.50 / gram (Simulated live rate)' with a green mini sparkline and '0% Making Charges' guarantee badge. User holdings: '2.500 grams (Current value ₹18,563.75)'. Dual primary action buttons: 'Buy Gold' and 'Sell to Wallet'. Quick amount chips: '₹500', '₹1,000', '₹5,000', '1 gram'."

- **Screen 15: Insurance Discovery & Claim Tracker**
  "PayWise insurance portal. Section 'Recommended for You' based on profile: Health Shield (₹10L cover, ₹540/mo), Two-Wheeler Comprehensive, Term Life. Tap opens policy benefits. Sub-tab 'Active Claims': 1 active claim for Health Policy showing horizontal animated 4-step progress line: 'Claim Submitted (Done)', 'Under Review (In Progress)', 'Approved', 'Disbursed'."

- **Screen 16: Lending & Loan Eligibility Screen**
  "PayWise instant lending eligibility screen. Income input slider: 'Monthly Income ₹65,000'. Calculated eligibility card: 'Approved Limit: Up to ₹5,00,000'. 3 loan offer cards: Personal Loan (10.5% p.a.), Instant Credit Line, Gold Loan. Dynamic EMI calculator slider (Tenure 6 to 36 months) updating live monthly EMI figure."

### Group F: Rewards, Wallet & Profile
- **Screen 17: Rewards & Wallet Screen**
  "PayWise rewards catalog and wallet screen. Segmented top toggle: 'Rewards' and 'Wallet'. Rewards view shows '1,450 Points Available' with count-up. Voucher redemption cards grid: '₹100 Amazon Gift Card (500 pts)', '₹250 Swiggy Voucher (1,000 pts)', '0.5g Digital Gold (3,500 pts - Disabled/Insufficient points)'. Wallet view shows '₹14,500 Balance' and 'Add Money' buttons (UPI, Debit Card)."

- **Screen 18: Profile & Settings Screen**
  "PayWise user profile screen. Profile header: 'Fauzan Baig', UPI ID 'fauzan@paywise', QR code badge. Feature settings card: 'PayPause Budget Guard' switch (On), 'Simulate Payment Failure' switch (Off - for demo testing), 'Monthly Category Budgets' button. System card: 'Reload Demo Data', 'Terms & Demo Mode Notice', 'Sign Out'."
