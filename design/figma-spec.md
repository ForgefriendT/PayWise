# PayWise Figma Design Specification

## Design Tokens

### Colors
- **Brand Primary**: `#5F259F` (Deep Purple)
- **Brand Dark**: `#3F1670`
- **Brand Soft**: `#F1E9FA` (Tinted surface/accent)
- **Success**: `#1E9E5A` (Green)
- **Warning**: `#E8A317` (Amber)
- **Danger**: `#D64545` (Red)
- **Info**: `#2F6FDE` (Blue)
- **Background**: `#F7F6FB` (Soft canvas)
- **Surface**: `#FFFFFF` (Card background)
- **Text Primary**: `#1B1530` (High contrast dark)
- **Text Secondary**: `#6B6780` (Muted violet-grey)
- **Divider**: `#ECE9F3`

### Category Palette
- Shopping: `#E83D84`
- Food Delivery: `#FF6B00`
- Entertainment: `#7B2CBF`
- Travel: `#0096C7`
- Bills & Utilities: `#F77F00`
- Grocery: `#2A9D8F`
- Health: `#E63946`
- Transfers / Others: `#457B9D`

### Typography (Plus Jakarta Sans)
- **Display**: 32px, Bold (w700), Line height: 40px
- **Title**: 22px, Semi-Bold (w600), Line height: 28px
- **Heading**: 18px, Semi-Bold (w600), Line height: 24px
- **Body**: 15px, Regular (w400), Line height: 22px
- **Caption**: 12px, Regular (w400), Line height: 16px
- Numbers: Tabular figures enabled

### Spacing & Grid
- Base grid: 4pt (4, 8, 12, 16, 24, 32)
- Target frame width: 390px (Mobile portrait)
- Touch targets: Minimum 48px height/width
- Corner radii:
  - Cards: 12px
  - Bottom sheets: 16px (top corners)
  - Chips & Pills: 999px (full radius)
  - Primary buttons: 12px

### Iconography
- Style: 24x24 viewBox, 1.75px stroke, rounded stroke-caps/joins, currentColor
- Source: Lucide / Tabler MIT line icons
- Explicit rule: Zero emojis in UI or components

---

## Screen Inventory (16 Core Screens & Sheets)

1. **Login Screen**: Clean auth screen with Email/Password and prominent "Continue as demo user" button.
2. **Home Screen**: Balance chip, quick UPI action grid, stat cards (success rate, cashback, reward points), PayPause summary card, recent transactions list, bills due strip.
3. **QR Scanner Screen**: Camera viewport with animated scan line, corner brackets, demo QR trigger, and manual UPI ID fallback.
4. **Contacts & Beneficiaries Screen**: Searchable contact list with UPI IDs and recent payment history preview.
5. **Pay Screen**: Large amount display, custom numpad, category selector chip, balance note, and transfer limit indicator.
6. **PayPause Bottom Sheet**: Animated Month Impact Ring, projection breakdown, 5-second countdown lock on "Pay anyway", and instant "Skip this one" action.
7. **Payment Success Screen**: Animated green tick circle, ripple, formatted amount, cashback earned, and reward points badge.
8. **History & Analytics Screen**: Month switcher, category spending pie chart with interactive legend, and filterable transaction list.
9. **Transaction Detail Sheet**: Step-by-step status timeline (Initiated -> Bank -> Success), counterparty UPI, UTR reference, and cashback summary.
10. **Bills & Recharges Screen**: Utility categories grid, saved bills list, reminder indicators, and autopay toggle.
11. **Autopay Bottom Sheet**: Bill autopay limit setter, payment date selector, and confirmation CTA.
12. **Credit Card Bill Screen**: Cards carousel with due amounts, due date alert banners, and 1% fee warning after 2 free monthly payments.
13. **Wealth Dashboard**: Portfolio summary (invested vs current, net gain), allocation donut, and sub-product cards.
14. **Digital Gold Screen**: Live ticking simulated gold price, current holdings (grams + value), 0% making charge badge, and buy/sell modal.
15. **Insurance & Claim Tracker**: Recommended policy cards, cover breakdown, and multi-step claim progress tracker.
16. **Lending & EMI Calculator**: Monthly income eligibility checker, loan offers cards, and dynamic EMI tenure slider.
17. **Rewards & Wallet Screen**: Reward points count-up, redemption catalog (vouchers, gold, cashback), wallet balance, and top-up options.
18. **Profile & Settings Screen**: User profile, PayPause toggle, simulated payment failure toggle, reload demo data button.
