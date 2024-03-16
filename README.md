# psDateFunctions

This PowerShell module began it's life when I had a requirement to calculate 'Patch Tuesday', the 2nd Tuesday of the Month, to automate patch release schedules. I have now extended it to cover all variations of the nth instance, or nth last instance of a particular weekday in a month, including Patch Tuesday.

It provides a comprehensive set of tools for finding specific dates within a month, catering to a wide range of needs. Key features include:

**First and Last Day of the Month**: Quickly retrieve the first or last date of any given month, simplifying scheduling and planning tasks that depend on these anchor points.

**Nth Instance Wizardry**: Need to schedule a meeting that doesn't clash with your secret superhero duties? Specify an ordinal number (e.g., 1st, 2nd, 3rd) alongside a day of the week and find the perfect date to balance both worlds. 

**Patch Tuesday**: For the IT warriors out there, calculating Patch Tuesday has never been easier. Plan your software update parties with precision and keep the digital realm secure, all while ensuring the punch bowl never empties.


## Installation
Summon this module from PowerShell Gallery:
```powershell
Install-Module -Name psDateFunctions
```

## Functions Included

- Get-FirstDayOfMonth
- Get-LastDayOfMonth
- Get-NthWeekdayOfMonth
- Get-NthLastWeekdayOfMonth
- Get-PatchTuesday (Alias)

- Get-1stSundayOfMonth 
- Get-1stMondayOfMonth 
- Get-1stTuesdayOfMonth
- Get-1stWednesdayOfMonth
- Get-1stThursdayOfMonth
- Get-1stFridayOfMonth
- Get-1stSaturdayOfMonth
- Get-2ndSundayOfMonth
- Get-2ndMondayOfMonth
- Get-2ndTuesdayOfMonth
- Get-2ndWednesdayOfMonth
- Get-2ndThursdayOfMonth
- Get-2ndFridayOfMonth
- Get-2ndSaturdayOfMonth
- Get-3rdSundayOfMonth
- Get-3rdMondayOfMonth
- Get-3rdTuesdayOfMonth
- Get-3rdWednesdayOfMonth
- Get-3rdThursdayOfMonth
- Get-3rdFridayOfMonth
- Get-3rdSaturdayOfMonth
- Get-4thSundayOfMonth
- Get-4thMondayOfMonth
- Get-4thTuesdayOfMonth
- Get-4thWednesdayOfMonth
- Get-4thThursdayOfMonth
- Get-4thFridayOfMonth
- Get-4thSaturdayOfMonth
- Get-5thSundayOfMonth
- Get-5thMondayOfMonth
- Get-5thTuesdayOfMonth
- Get-5thWednesdayOfMonth
- Get-5thThursdayOfMonth
- Get-5thFridayOfMonth
- Get-5thSaturdayOfMonth

- Get-LastSundayOfMonth
- Get-LastMondayOfMonth
- Get-LastTuesdayOfMonth
- Get-LastWednesdayOfMonth
- Get-LastThursdayOfMonth
- Get-LastFridayOfMonth
- Get-LastSaturdayOfMonth
- Get-2ndLastSundayOfMonth
- Get-2ndLastMondayOfMonth
- Get-2ndLastTuesdayOfMonth
- Get-2ndLastWednesdayOfMonth
- Get-2ndLastThursdayOfMonth
- Get-2ndLastFridayOfMonth
- Get-2ndLastSaturdayOfMonth
- Get-3rdLastSundayOfMonth
- Get-3rdLastMondayOfMonth
- Get-3rdLastTuesdayOfMonth
- Get-3rdLastWednesdayOfMonth
- Get-3rdLastThursdayOfMonth
- Get-3rdLastFridayOfMonth
- Get-3rdLastSaturdayOfMonth
- Get-4thLastSundayOfMonth
- Get-4thLastMondayOfMonth
- Get-4thLastTuesdayOfMonth
- Get-4thLastWednesdayOfMonth
- Get-4thLastThursdayOfMonth
- Get-4thLastFridayOfMonth
- Get-4thLastSaturdayOfMonth
- Get-5thLastSundayOfMonth
- Get-5thLastMondayOfMonth
- Get-5thLastTuesdayOfMonth
- Get-5thLastWednesdayOfMonth
- Get-5thLastThursdayOfMonth
- Get-5thLastFridayOfMonth
- Get-5thLastSaturdayOfMonth

## Examples

Want to know when to host your next wizard's conclave (or just a friendly get-together)? Here's how:
```powershell
# Grab the first day of the month to start planning.
Get-FirstDayOfMonth -Month 11 -Year 2024

# Find out when the next "Patch Tuesday" falls to avoid any IT calamities.
Get-PatchTuesday -Month 12 -Year 2025

# Discover the 3rd Friday of the month for that long-overdue movie night.
Get-3rdFridayOfMonth -Month 10 -Year 2024

# If you're really brave, you can find the 5th last Monday of April 2007 - I don't know why either.
Get-5thLastMondayOfMonth -Month 4 -Year 2007
```

Whether you're managing event schedules, performing date-based calculations, or coordinating IT maintenance tasks, this module provides the essential tools to find relevant dates with ease and precision. Its intuitive design and comprehensive coverage of date-related queries make it an indispensable tool for PowerShell users seeking to streamline their date manipulation tasks.
