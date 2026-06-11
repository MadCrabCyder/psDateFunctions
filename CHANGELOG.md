# Changelog

All notable changes to `psDateFunctions` are documented in this file.

## 1.5.6 (11-Jun-2026)

- Clean up `README.md` structure and move release history into `CHANGELOG.md`
- Add a changelog link in `README.md` in place of the embedded release notes section
- Add additional aliases to core month-boundary functions, including `Get-StartOfMonth` and `Get-EndOfMonth`
- Update core nth date functions to calculate the target day-of-month directly instead of constructing the result via `AddDays()`
- Add explanatory comments to the core nth date arithmetic to mirror the standalone gist implementation style

## 1.5.5 (10-Jun-2026)

- Improve the stand-alone `Get-PatchTuesday` gist with parameter validation attributes and interactive help messages
- Add a `Date` parameter set that defaults to the current month and supports pipeline input
- Expand gist help examples for direct date input, no-parameter usage, and pipeline usage
- Refine gist arithmetic comments and calculate the second Tuesday using direct day-of-month construction

## 1.5.4 (10-Jun-2026)

- Refactor wrapper generation to use an external template file for generated function help and body content
- Add clearer template loading and validation in `meta-functions.ps1`
- Centralize wrapper generation constants for supported wrapper targets, days, and ordinals
- Update wrapper generation to only rewrite files when content has actually changed

## 1.5.3 (05-Jun-2026)

- Add a stand-alone `Get-PatchTuesday` gist to demonstrate the direct arithmetic implementation without requiring installation of the full module
- Include tests for the gist implementation
- Update `README.md` to summarize the included function families instead of listing every generated function explicitly
- Expand `README.md` examples to better cover generic nth, nth-last, weekday-only, and Patch Tuesday scenarios

## 1.5.2 (05-Jun-2026)

- Improve efficiency of core public date functions by replacing `Get-Date` month anchor creation with direct `[datetime]::new(...)` construction
- Simplify `Get-LastDayInMonth` to use `[datetime]::DaysInMonth(...)` for direct end-of-month calculation
- Inline direct month anchor calculation in `Get-NthDayOfWeekInMonth` and `Get-NthLastDayOfWeekInMonth`
- Make `DayOfWeek` arithmetic explicit in nth date calculations

## 1.5.1 (04-Jun-2026)

- Rename `Get-NthDayOfWeekInMonth` and `Get-NthLastDayOfWeekInMonth` test files to `*.Tests.ps1` so Pester discovers them
- Update nth date tests from `-WeekDay` to `-DayOfWeek`
- Normalize remaining loop-style test cases to Pester `-ForEach`

## 1.5.0 (26-Jan-2026)

- Terminology update for Weekday, DayOfWeek, etc.
- Rename functions previously named `*OfMonth` to `*InMonth`
- rename functions and parameters inline with new terminology
- Introduce new functions `Get-1stWeekdayInMonth`, `Get-LastWeekdayInMonth` and `Get-NearestWeekday`
- Promote `Get-PatchTuesday` to a wrapper function instead of alias of `Get-2ndTuesdayInMonth`

## 1.1.0 (23-Jan-2026)

- Added `-Weekday` switch to `Get-1stDayInMonth` and `Get-LastDayInMonth` - Enables skipping weekends by default (Saturday and Sunday) to return the first/last weekday of a month.
- Added `-ExcludeDays` parameter to `Get-1stDayInMonth` and `Get-LastDayInMonth` - Allows customization of which days of the week to skip (e.g., `Sunday, Monday`), offering fine-grained control for custom workweek definitions.

## 1.0.0 (25-Mar-2024)

- Promote 0.0.3 to release version 1!

## 0.0.3 (22-Mar-2024)

- Added Release Notes to README.md
- Added documentation to functions
- Added restriction for Nth to functions Get-NthDayOfWeekInMonth and Get-NthLastDayOfWeekInMonth
- Added validation for Year to be between 1 and 9999
- Refactored meta functions
- Renamed function Get-FirstDayInMonth to Get-1stDayInMonth for consistancy
- Removed CmdletBinding attribute from functions

## 0.0.2 (19-Mar-2024)

- Fixed typo in README
- Added OutputType as System.DateTime to all functions
- Added Tags to project manifest file

## 0.0.1 (14-Mar-2024)

- Initial Release
