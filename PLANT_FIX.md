# Plan to Fix Transfer Issues

## Issues Identified:
1. **main_status_card.dart**: Private class `_MainStatusCard` - need make public
2. **insight_card.dart, overview_block.dart, action_button.dart, open_full_screen_link.dart**: Empty or missing public classes
3. **expense_control_sheet.dart**: Uses `_MainStatusCard`, `_InsightCard`, `_ActionButtons`, `_OpenFullScreenLink` which are either empty or not properly imported

## Fix Plan:

### Step 1: Fix main_status_card.dart
- Rename `_MainStatusCard` → `MainStatusCard` (remove underscore to make public)

### Step 2: Create Widgets for Empty Files
- **insight_card.dart**: Create `InsightCard` widget
- **overview_block.dart**: Create `OverviewBlock` widget  
- **action_button.dart**: Create `ActionButtons` widget
- **open_full_screen_link.dart**: Create `OpenFullScreenLink` widget

### Step 3: Update expense_control_sheet.dart
- Add proper imports for all components from control_sheet_screen directory
- Use public class names

### Step 4: Create barrel export file
- Create `control_sheet_screen.dart` to export all widgets

## Dependencies:
- All widgets use Flutter Material package
- No additional dependencies needed
