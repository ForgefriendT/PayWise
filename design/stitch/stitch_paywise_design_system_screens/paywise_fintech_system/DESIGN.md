---
name: PayWise Fintech System
colors:
  surface: '#FFFFFF'
  surface-dim: '#dad9de'
  surface-bright: '#faf9fe'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f4f3f8'
  surface-container: '#eeedf2'
  surface-container-high: '#e8e7ec'
  surface-container-highest: '#e3e2e7'
  on-surface: '#1a1c1f'
  on-surface-variant: '#4b4452'
  inverse-surface: '#2f3034'
  inverse-on-surface: '#f1f0f5'
  outline: '#7c7483'
  outline-variant: '#cdc3d4'
  surface-tint: '#7841b9'
  primary: '#470085'
  on-primary: '#ffffff'
  primary-container: '#5f259f'
  on-primary-container: '#cda3ff'
  inverse-primary: '#dab9ff'
  secondary: '#714ba4'
  on-secondary: '#ffffff'
  secondary-container: '#c79efd'
  on-secondary-container: '#552f86'
  tertiary: '#332f3b'
  on-tertiary: '#ffffff'
  tertiary-container: '#494552'
  on-tertiary-container: '#b9b3c3'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#eedbff'
  primary-fixed-dim: '#dab9ff'
  on-primary-fixed: '#2a0053'
  on-primary-fixed-variant: '#5f259f'
  secondary-fixed: '#eddcff'
  secondary-fixed-dim: '#d8b9ff'
  on-secondary-fixed: '#290055'
  on-secondary-fixed-variant: '#58328a'
  tertiary-fixed: '#e7dff0'
  tertiary-fixed-dim: '#cbc4d4'
  on-tertiary-fixed: '#1d1a25'
  on-tertiary-fixed-variant: '#494552'
  background: '#faf9fe'
  on-background: '#1a1c1f'
  surface-variant: '#e3e2e7'
  text-primary: '#1B1530'
  text-secondary: '#6B6780'
  divider: '#ECE9F3'
  semantic-success: '#1E9E5A'
  semantic-warning: '#E8A317'
  semantic-danger: '#D64545'
  semantic-info: '#2F6FDE'
  category-shopping: '#E83D84'
  category-food: '#FF6B00'
  category-entertainment: '#7B2CBF'
  category-travel: '#0096C7'
  category-bills: '#F77F00'
  category-grocery: '#2A9D8F'
  category-health: '#E63946'
  category-transfers: '#457B9D'
typography:
  display-hero:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  display-hero-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.02em
  title-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.015em
  heading-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 22px
    letterSpacing: 0em
  body-md-bold:
    fontFamily: Plus Jakarta Sans
    fontSize: 15px
    fontWeight: '600'
    lineHeight: 22px
    letterSpacing: 0em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
    letterSpacing: 0.01em
  caption-xs:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
    letterSpacing: 0.02em
  caption-xs-bold:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  currency-display:
    fontFamily: Plus Jakarta Sans
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.03em
  currency-keypad:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: 0em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-compact: 0.75rem
  margin: 1rem
  margin-screen: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
---

## Brand & Style

The design system establishes a calm, trustworthy, and intentional fintech environment designed to counteract impulsive spending and payment anxiety. Built around mindfulness and financial clarity, the visual tone blends high-velocity financial utility with a deliberate, reassuring poise.

### Movement & Personality
- **Style:** Contemporary Neo-Fintech Minimalism. Clean, airy whitespace is anchored by purposeful deep royal purples and clear chromatic semantics. Surfaces prioritize high legibility, clean structural hierarchy, and tactile micro-affordances.
- **Personality:** Decisive, intelligent, reassuring, and meticulous. It replaces typical fintech clutter and carnival-like gamification with structured data density and calm financial friction (such as deliberate budget intervention locks).
- **Iconography Philosophy:** Strict zero-emoji policy across all interfaces and microcopy. Visual communication uses pure 1.75px stroked monochrome line icons (Lucide / Tabler style) with rounded terminals and joins.

## Colors

The color system operates with strict intent. The chromatic backbone is driven by the primary `#5F259F` (deep royal purple) paired with its deep structural anchor `#3F1670` and tinted interactive surface `#F1E9FA`. The background canvas sits on an ultra-subtle tinted grey-purple `#F7F6FB`, allowing `#FFFFFF` cards to stand out with crisp distinction.

### Semantic & Categorical Rules
- **Text Contrast:** `#1B1530` handles high-contrast headings, numeric totals, and key data points. `#6B6780` handles secondary context, timestamps, and metadata.
- **Divider Tone:** `#ECE9F3` provides razor-thin structural boundaries without visual heaviness.
- **Status Indicators:** Success (`#1E9E5A`), Warning (`#E8A317`), Danger (`#D64545`), and Info (`#2F6FDE`) are reserved strictly for transactional states, progress rings, and risk intervention banners.
- **Expense Categorization:** 8 dedicated category accents enable rapid visual parsing across graphs, ledger rows, and allocation charts without clashing with the purple brand identity.

## Typography

The design system uses **Plus Jakarta Sans** across all roles to ensure geometric purity, friendly clarity, and crisp digital rendering on compact mobile screens.

### Numerical & Currency Formatting
- **Tabular Figures:** All financial figures, account balance badges, transaction lists, and clock counters must strictly use `font-variant-numeric: tabular-nums` (or OpenType `tnum`). This prevents layout jitter during real-time balance count-ups and gold price ticker updates.
- **Rupee Glyph (₹):** Currency amounts consistently feature the standardized Indian Rupee symbol prefix (`₹`), weighted uniformly with its trailing numeric data.

## Layout & Spacing

Layout and component distances conform strictly to a base 4pt vertical rhythm (4px, 8px, 12px, 16px, 24px, 32px).

### Viewport & Grid Architecture
- **Primary Frame:** Optimized natively for a **390px** mobile viewport width.
- **Canvas Margins:** Top-level screen padding defaults to 16px (`1rem`) on outer left/right rails, expanding to 20px (`1.25rem`) on hero and wallet dashboard screens for heightened focus.
- **Internal Column Grid:** Contextually 4 columns on mobile viewports with an 8px to 12px gutter.
- **Touch Targets:** Any interactive control, filter chip, switch, or icon tap zone must satisfy a minimum height and width of **48px**, utilizing invisible touch padding when visual elements are smaller.

## Elevation & Depth

Visual hierarchy uses a refined blend of subtle ambient shadows and low-contrast surface dividers. This avoids excessive elevation steps that clutter small mobile devices.

### Surface Hierarchy & Shadows
- **Level 0 (Canvas Base):** Tinted neutral background (`#F7F6FB`), entirely flat without shadows.
- **Level 1 (Card & Content Blocks):** Pure white surfaces (`#FFFFFF`) sitting over the canvas. Standard cards carry an ultra-subtle ambient drop shadow: `0px 2px 8px rgba(27, 21, 48, 0.04)` combined with an optional 1px subtle outline border using `#ECE9F3`.
- **Level 2 (Interactive Floating Elements & Quick Action Nav):** Raised floating controls, central scan actions, and segmented pills utilize a diffused shadow: `0px 4px 16px rgba(95, 37, 159, 0.12)`.
- **Level 3 (Modal Sheets & PayPause Interventions):** Bottom sheets slide in from the lower screen edge over a 50% opacity neutral-dark backdrop (`rgba(27, 21, 48, 0.50)`). Sheets possess an elevation shadow of `0px -8px 24px rgba(27, 21, 48, 0.08)`.

## Shapes

The system relies on an intentional scale of corner radii that clearly delineates structural containers from transient floating controls.

### Radius Assignments
- **Cards & Data Modules:** Fixed at `12px` (`0.75rem`) for standard content containers, portfolio blocks, and list items.
- **Primary & Secondary Action Buttons:** Fixed at `12px` (`0.75rem`), aligning directly with card boundaries.
- **Bottom Sheets:** Top-left and top-right corners strictly take `16px` (`1rem`), with 0px at the bottom edges.
- **Chips, Category Selectors & Balance Pills:** Full pill contour at `999px` to emphasize tap affordance and contrast against rectangular transaction cards.
- **Form Inputs & Keypad Keys:** `12px` corner radius.

## Components

### Buttons & Interactive Controls
- **Primary Button:** Background `#5F259F`, foreground `#FFFFFF`, height 52px, corner radius 12px, font-weight 600. Active press scale state: 0.98.
- **Secondary / Demo Outline Button:** Background transparent or `#F1E9FA`, border 1.5px solid `#5F259F`, text `#5F259F`.
- **Countdown Lock Button:** When in PayPause mode, button displays dynamic circular progress with a 5-second countdown timer. Surface remains visually locked until expiry.
- **Quick Action Grid Buttons:** 56x56px circular rounded containers with 1.75px monochrome icon centered within.

### Chips & Filter Pills
- Fully rounded (`999px`), 36px to 40px height with 12px to 16px horizontal padding.
- **Unselected:** Background `#FFFFFF`, border 1px solid `#ECE9F3`, text `#6B6780`.
- **Selected:** Background `#F1E9FA`, border 1px solid `#5F259F`, text `#5F259F`, font-weight 600.

### Input Fields & Numeric Keypad
- **Text Inputs:** White card surface, 52px height, 12px radius, 1px border `#ECE9F3`. On focus: border shifts to 1.5px `#5F259F` with subtle purple ambient glow. Floating label in `#6B6780`.
- **Amount Entry Field:** Centered borderless display with massive 36px/44px typography, static currency symbol (`₹`), and blinking cursor in `#5F259F`.
- **Custom Keypad:** 3x4 grid embedded seamlessly into canvas. Keys have minimum 54px touch height, displaying tabular figures without borders.

### Cards & Ledger Lists
- **Cards:** Background `#FFFFFF`, 12px radius, padding 16px. Clean 1px bottom divider `#ECE9F3` between inner list rows.
- **Transaction Item:** Left-aligned 40px category icon container tinted in corresponding category color (15% opacity tint with vibrant 1.75px icon), title and timestamp stacked, and right-aligned tabular currency amount (signed `-₹` or `+₹` with `#1E9E5A`).

### PayPause Bottom Sheet & Budget Intervention
- Sheet opens from bottom anchored with a top drag handle (36px wide, 4px height, `#ECE9F3`, 8px margin-top).
- Houses the Month Impact Ring chart illustrating budget escalation with clear semantic coloring (`#E8A317` warning for >80% threshold).
- Clear, unhurried secondary action "Skip this one (save ₹X)" styled in muted tonal surface above the primary countdown action.