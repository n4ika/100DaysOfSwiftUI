# WeSplit

A bill splitting app built during Days 16-18 of the 100 Days of SwiftUI challenge.

## Features

- Enter bill amount with currency formatting
- Select number of people (2-24)
- Choose tip percentage (0-100%)
- Automatically calculates total bill and amount per person
- Clean, intuitive SwiftUI interface

## Personal Enhancements

Beyond the original tutorial, I implemented:

- **Optional Double for bill amount**: Changed `checkAmount` from `Double` to `Double?`
- **Nil-coalescing operators**: Used `??` in calculations to handle nil values
- **Improved UX**: Users now see a clean empty text field instead of having to clear "$0.00"
- **Better labeling**: Added "Total Bill" section header and "Bill amount" placeholder

## Technical Details

**Built with:**
- SwiftUI
- @State for reactive data
- @FocusState for keyboard management
- Form and Section components
- Picker with navigation style
- Currency formatting with Locale

**Key SwiftUI Concepts:**
- State management
- Focus state and keyboard handling
- Form layouts and sections
- Data binding with $
- Computed properties for reactive calculations

## Screenshots

![WeSplit App]([screenshot.png](wesplit-screenshot.png)

## What I Learned

- How to build forms in SwiftUI
- State management patterns
- Working with optionals in UI contexts
- Currency formatting and locale handling
- Focus management for better UX
- Applying previous concepts (optionals, nil-coalescing) to solve real UX problems

---

Part of my [100 Days of SwiftUI](../README.md) journey!
