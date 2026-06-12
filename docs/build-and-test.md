# Build And Test

This document describes the local `Invoke-Build` entrypoints for validation, testing, cleaning, and building the module.

## Prerequisites

Install the required PowerShell modules:

```powershell
Install-Module InvokeBuild -Scope CurrentUser
Install-Module Pester -Scope CurrentUser
Install-Module ModuleBuilder -Scope CurrentUser
```

## Main Commands

The primary local commands are:

```powershell
Invoke-Build Test
Invoke-Build Build
```

## Available Tasks

The task definitions live in `.build.ps1`.

### `Validate`

Checks that required build inputs exist and can be loaded:

- `Source/psDateFunctions.psd1`
- `build.psd1`
- `Source/Tests`
- `CHANGELOG.md`

It also imports the source manifest and build preferences file to catch malformed data early.

Run it directly:

```powershell
Invoke-Build Validate
```

### `Analyze`

Runs lightweight PowerShell syntax analysis across repo `.ps1` and `.psm1` files by parsing them with the PowerShell parser.

This is currently syntax-focused analysis, not `PSScriptAnalyzer` rule enforcement.

Run it directly:

```powershell
Invoke-Build Analyze
```

### `Test`

Runs the full validation path used by CI:

- `Validate`
- `Analyze`
- Pester against `Source/Tests`

Run it with:

```powershell
Invoke-Build Test
```

This is the preferred local pre-commit check.

### `Clean`

Deletes the contents of the repo `Output` folder.

Run it directly:

```powershell
Invoke-Build Clean
```

### `Build`

Builds the module using `ModuleBuilder`.

Task order:

- `Clean`
- `Validate`
- `Build`

Run it with:

```powershell
Invoke-Build Build
```

## Typical Local Workflow

For day-to-day development:

```powershell
Invoke-Build Test
Invoke-Build Build
```

For release prep:

```powershell
Invoke-Build Test
Invoke-Build Build
./publish.ps1 -WhatIf
```

## CI Usage

GitHub Actions now uses:

```powershell
Invoke-Build Test
```

This keeps local and CI validation paths aligned.
