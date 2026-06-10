# psDateFunctions
![Published Version](https://img.shields.io/powershellgallery/v/psDateFunctions.svg?style=flat&logo=powershell&label=Published%20Version)
![Downloads](https://img.shields.io/powershellgallery/dt/psDateFunctions.svg?style=flat&logo=powershell&label=PSGallery%20Downloads)
![Tests](https://github.com/MadCrabCyder/psDateFunctions/actions/workflows/test-run-pester.yml/badge.svg)


This PowerShell module began it's life when I had a requirement to calculate 'Patch Tuesday', the 2nd Tuesday of the Month, to automate patch release schedules. I have now extended it to cover all variations of the nth instance, or nth last instance of a particular DayOfWeek in a month, including Patch Tuesday.

It provides a comprehensive set of tools for finding specific dates within a month, catering to a wide range of needs. Key features include:

**First and Last Day of the Month**: Quickly retrieve the first or last date of any given month, simplifying scheduling and planning tasks that depend on these anchor points.

**First and Last Weekday of the Month**: Easily determine the first or last business day (Monday–Friday) of any month. Perfect for making sure important work doesn’t accidentally land on a weekend.

**Find the nearest Weekday**: Got a date that falls on a weekend? No problem. Automatically roll forward or backward to the nearest weekday, ideal for handling paydays, or any schedule that refuses to acknowledge Saturdays and Sundays.

**Nth Instance Wizardry**: Need to schedule a meeting that doesn't clash with your secret superhero duties? Specify an ordinal number (e.g., 1st, 2nd, 3rd) alongside a day of the week and find the perfect date to balance both worlds.

**Patch Tuesday**: For the IT warriors out there, calculating Patch Tuesday has never been easier. Plan your software update parties with precision and keep the digital realm secure, all while ensuring the punch bowl never empties.

## ⚠️ Terminology Update in v1.5 – Breaking Changes

As of version 1.5, the module introduces clearer and more precise terminology to avoid ambiguity around day classifications. These changes affect function names, parameter names, and documentation.

### New Terminology

| Term        | Meaning                                   |
| ----------- | ----------------------------------------- |
| `DayOfWeek` | Any calendar day, Monday through Sunday   |
| `Weekday`   | Monday through Friday only                |
| `Weekend`   | Saturday and Sunday only                  |

### Why the Change?

Previous versions used terms like Weekday to refer to any day of the week, including weekends; which can be misleading, since "weekday" is commonly understood to mean Monday–Friday.

To improve clarity and align with standard conventions and developer expectations, the module has adopted more precise naming:
- **DayOfWeek** is now used to refer to any day (Sunday–Saturday)
- **Weekday** is reserved for business days (Monday–Friday)
- **Weekend** explicitly means Saturday and Sunday

### Naming Convention & Function Renames

When the Weekday parameter was renamed to DayOfWeek, some function names (like `Get-NthDayOfWeekOfMonth`) became awkward and did not roll off the tongue well. To improve readability and fluency, those were updated to use **InMonth** instead of **OfMonth**.

This change highlighted inconsistencies in the rest of the module, so for consistency across the board, all functions previously named with **OfMonth** have been renamed to **InMonth**.


### Breaking Changes
- For consistency across the module, all functions previously named `*OfMonth` have been renamed to `*InMonth` (for example, `Get-1stSundayOfMonth` → `Get-1stSundayInMonth`, `Get-LastFridayOfMonth` → `Get-LastFridayInMonth`)
- Rename parameter `WeekDay` to `DayOfWeek`
- Rename parameter `Workday` to `Weekday`

> ⚠️ If your scripts reference the old `*OfMonth` function names or rely on previous terminology, you will need to update them to use the new `*InMonth` names and parameter conventions.


## Installation
Summon this module from PowerShell Gallery:
```powershell
Install-Module -Name psDateFunctions
```

## Functions Included

Core functions:
- `Get-1stDayInMonth` (Alias: `Get-FirstDayInMonth`)
- `Get-1stWeekdayInMonth` (Alias: `Get-FirstWeekdayInMonth`)
- `Get-LastDayInMonth`
- `Get-LastWeekdayInMonth`
- `Get-NthDayOfWeekInMonth`
- `Get-NthLastDayOfWeekInMonth`
- `Get-NearestWeekday`
- `Get-PatchTuesday`

Generated convenience functions:
- `Get-{Nth}{Day}InMonth`
- `Get-{Nth}Last{Day}InMonth`
- `Get-Last{Day}InMonth`

Where:
- `{Nth}` = `1st`, `2nd`, `3rd`, `4th`, `5th`
- `{Day}` = `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`

Examples:
- `Get-1stSundayInMonth`
- `Get-3rdFridayInMonth`
- `Get-LastMondayInMonth`
- `Get-2ndLastTuesdayInMonth`
- `Get-5thSaturdayInMonth`


## Examples

Want to know when to host your next wizard's conclave (or just a friendly get-together)? Here's how:
```powershell
# Grab the first day of the month to start planning.
Get-1stDayInMonth -Month 11 -Year 2024

# Get the first Weekday of the month, you don't work on weekends, right?
Get-1stDayInMonth -Month 11 -Year 2024 -Weekday

# Get the last day of the month, but not the weekend or Monday, because no one likes Mondays.
Get-LastDayInMonth -Month 10 -Year 2024 -Exclude Saturday, Sunday, Monday

# Payday is the 15th… unless it’s a weekend. Then payroll kindly moves it to Friday.
Get-NearestWeekday -Day 15 -Month 6 -Year 2025 -Before

# Find out when the next "Patch Tuesday" falls to avoid any IT calamities.
Get-PatchTuesday -Month 12 -Year 2025

# Discover the 3rd Friday of the month for that long-overdue movie night.
Get-3rdFridayInMonth -Month 10 -Year 2024

# Get the last weekday of a month.
Get-LastWeekdayInMonth -Month 8 -Year 2025

# Use a custom workweek by excluding Friday, Saturday, and Sunday.
Get-1stWeekdayInMonth -Month 6 -Year 2026 -ExcludeDays Friday, Saturday, Sunday

# If you're really brave, you can find the 5th last Monday of April 2007 - I don't know why either.
Get-5thLastMondayInMonth -Month 4 -Year 2007

# Get the 1st Friday of every month next year. Because recurring drinks are important.
1..12 | ForEach-Object { Get-1stFridayInMonth -Month $_ -Year 2026 }

# Get Patch Tuesday for every month this year.
1..12 | ForEach-Object { Get-PatchTuesday -Month $_ -Year 2026 }
```

Whether you're managing event schedules, performing date-based calculations, or coordinating IT maintenance tasks, this module provides the essential tools to find relevant dates with ease and precision. Its intuitive design and comprehensive coverage of date-related queries make it an indispensable tool for PowerShell users seeking to streamline their date manipulation tasks.


## Release Notes

> ### 1.5.4 (10-Jun-2026)
> - Refactor wrapper generation to use an external template file for generated function help and body content
> - Add clearer template loading and validation in `meta-functions.ps1`
> - Centralize wrapper generation constants for supported wrapper targets, days, and ordinals
> - Update wrapper generation to only rewrite files when content has actually changed

> ### 1.5.3 (05-Jun-2026)
> - Add a stand-alone `Get-PatchTuesday` gist to demonstrate the direct arithmetic implementation without requiring installation of the full module
> - Include tests for the gist implementation
> - Update `README.md` to summarize the included function families instead of listing every generated function explicitly
> - Expand `README.md` examples to better cover generic nth, nth-last, weekday-only, and Patch Tuesday scenarios

> ### 1.5.2 (05-Jun-2026)
> - Improve efficiency of core public date functions by replacing `Get-Date` month anchor creation with direct `[datetime]::new(...)` construction
> - Simplify `Get-LastDayInMonth` to use `[datetime]::DaysInMonth(...)` for direct end-of-month calculation
> - Inline direct month anchor calculation in `Get-NthDayOfWeekInMonth` and `Get-NthLastDayOfWeekInMonth`
> - Make `DayOfWeek` arithmetic explicit in nth date calculations

> ### 1.5.1 (04-Jun-2026)
> - Rename `Get-NthDayOfWeekInMonth` and `Get-NthLastDayOfWeekInMonth` test files to `*.Tests.ps1` so Pester discovers them
> - Update nth date tests from `-WeekDay` to `-DayOfWeek`
> - Normalize remaining loop-style test cases to Pester `-ForEach`

> ### 1.5.0 (26-Jan-2026)
> - Terminology update for Weekday, DayOfWeek, etc.
> - Rename functions previously named `*OfMonth` to `*InMonth`
> - rename functions and parameters inline with new terminology
> - Introduce new functions `Get-1stWeekdayInMonth`, `Get-LastWeekdayInMonth` and `Get-NearestWeekday`
> - Promote `Get-PatchTuesday` to a wrapper function instead of alias of `Get-2ndTuesdayInMonth`

> ### 1.1.0 (23-Jan-2026)
> - Added `-Weekday` switch to `Get-1stDayInMonth` and `Get-LastDayInMonth` - Enables skipping weekends by default (Saturday and Sunday) to return the first/last weekday of a month.
> - Added `-ExcludeDays` parameter to `Get-1stDayInMonth` and `Get-LastDayInMonth` - Allows customization of which days of the week to skip (e.g., `Sunday, Monday`), offering fine-grained control for custom workweek definitions.

> ### 1.0.0 (25-Mar-2024)
> - Promote 0.0.3 to release version 1!

> ### 0.0.3 (22-Mar-2024)
> - Added Release Notes to README.md
> - Added documentation to functions
> - Added restriction for Nth to functions Get-NthDayOfWeekInMonth and Get-NthLastDayOfWeekInMonth
> - Added validation for Year to be between 1 and 9999
> - Refactored meta functions
> - Renamed function Get-FirstDayInMonth to Get-1stDayInMonth for consistancy
> - Removed CmdletBinding attribute from functions

> ### 0.0.2 (19-Mar-2024)
> - Fixed typo in README
> - Added OutputType as System.DateTime to all functions
> - Added Tags to project manifest file

> ### 0.0.1 (14-Mar-2024)
> - Initial Release
