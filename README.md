# psDateFunctions
![Published Version](https://img.shields.io/powershellgallery/v/psDateFunctions.svg?style=flat&logo=powershell&label=Published%20Version)
![Downloads](https://img.shields.io/powershellgallery/dt/psDateFunctions.svg?style=flat&logo=powershell&label=PSGallery%20Downloads)
![Tests](https://github.com/MadCrabCyder/psDateFunctions/actions/workflows/test-run-pester.yml/badge.svg)

This PowerShell module began life as a simple way to calculate *Patch Tuesday* (the second Tuesday of each month) for automated patch scheduling. It has since grown into a comprehensive date utility module capable of calculating first, last, nth, and nth-last occurrences of any day of the week within a month.

## Why use PSDateFunctions?

Date calculations often require custom logic, edge-case handling, and repetitive code. PSDateFunctions provides tested, reusable commands for common scheduling and calendar-related tasks, allowing you to focus on your automation rather than date arithmetic.

It provides a comprehensive set of tools for finding specific dates within a month, catering to a wide range of needs. Key features include:

**First and Last Day of the Month**: Quickly retrieve the first or last date of any given month, simplifying scheduling and planning tasks that depend on these anchor points.

**First and Last Weekday of the Month**: Easily determine the first or last business day of any month. By default, weekends are excluded, but custom workweeks can be defined using `-ExcludeDays` to accommodate regional calendars and business rules.

**Find the nearest Weekday**: Got a date that falls on a weekend? No problem. Automatically roll forward or backward to the nearest valid weekday, with support for custom workweeks via `-ExcludeDays`.


**Nth Instance Wizardry**: Need to schedule a meeting that doesn't clash with your secret superhero duties? Specify an ordinal number (e.g., 1st, 2nd, 3rd) alongside a day of the week and find the perfect date to balance both worlds.

**Patch Tuesday**: For the IT warriors out there, calculating Patch Tuesday has never been easier. Plan your software update parties with precision and keep the digital realm secure, all while ensuring the punch bowl never empties.

## Quick Start

```powershell
# Install from the PowerShell Gallery
Install-Module -Name psDateFunctions

# When is Patch Tuesday this month?
Get-PatchTuesday -Month 12 -Year 2025

# First weekday of next month
Get-1stWeekdayInMonth -Month 1 -Year 2026

# Payday is the 15th… unless it’s a weekend. Then payroll kindly moves it to Friday.
Get-NearestWeekday -Day 15 -Month 6 -Year 2025 -Before
```

## ⚠️ Terminology Update in v1.5 – Breaking Changes

As of version 1.5, the module introduces clearer and more precise terminology to avoid ambiguity around day classifications. These changes affect function names, parameter names, and documentation.

### New Terminology

| Term        | Meaning                                   |
| ----------- | ----------------------------------------- |
| `DayOfWeek` | Any calendar day, Sunday through Saturday |
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
Install from the PowerShell Gallery:

```powershell
Install-Module -Name psDateFunctions
```

## Functions Included

Core functions:
- `Get-1stDayInMonth` (Aliases: `Get-FirstDayInMonth`, `Get-StartOfMonth`)
- `Get-1stWeekdayInMonth` (Alias: `Get-FirstWeekdayInMonth`)
- `Get-LastDayInMonth` (Alias: `Get-EndOfMonth`)
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
Get-1stWeekdayInMonth -Month 11 -Year 2024

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

Whether you're managing event schedules, coordinating patch deployments, automating payroll processing, or performing date-based calculations, PSDateFunctions provides simple, reliable commands for finding the dates that matter.


## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for release history and version notes.
