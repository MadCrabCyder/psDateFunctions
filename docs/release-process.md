# Release Process

This document describes the current release flow for `psDateFunctions`, including local validation, GitHub Actions behavior, versioning expectations, and publishing to PowerShell Gallery.

## Release Prerequisites

Before creating a release:

- Update `Source/psDateFunctions.psd1` so `ModuleVersion` matches the intended release version.
- Add the matching version entry to `CHANGELOG.md`.
- Ensure tests pass locally.
- Commit and push the release changes.

Release tags use this format:

```text
<major>.<minor>.<patch>
```

Example:

```text
1.5.7
```

The release workflow also accepts an optional `v` prefix, but this repo's existing tags use bare semantic versions.

## Local Validation

The repo now uses `Invoke-Build` tasks for local validation and build orchestration.

Useful local commands:

```powershell
Invoke-Build Test
Invoke-Build Build
Invoke-Build Publish
```

`Invoke-Build Test` runs:

- `Validate`
- `Analyze`
- `Test`

`Invoke-Build Build` runs:

- `Clean`
- `Validate`
- `Build`

## Publish Tasks

Publishing is now handled by `Invoke-Build` tasks in `.build.ps1`.

Available publish tasks:

- `Publish`
- `PublishWhatIf`
- `PublishBuilt`
- `PublishBuiltWhatIf`

`Publish` runs the full local release path:

- `Test`
- `Build`
- `PublishBuilt`

`PublishBuilt` assumes tests and build already ran and publishes the existing output.

All publish tasks require:

- `PSGALLERY_API_KEY`

## GitHub Actions

There are two relevant workflows:

- `.github/workflows/test-run-pester.yml`
- `.github/workflows/release-on-tag.yml`

### Test Workflow

The test workflow runs on normal `push` and `pull_request` events and executes:

```powershell
Invoke-Build Test
```

This keeps validation, syntax analysis, and Pester execution behind one entrypoint.

### Release Workflow

The release workflow supports two modes:

1. Tag-triggered release on `X.Y.Z` or `vX.Y.Z`
2. Manual `workflow_dispatch` dry-run or release

The workflow performs these steps:

1. Resolve the effective release tag and version.
2. Install `InvokeBuild`, `Pester`, and `ModuleBuilder`.
3. Run `Invoke-Build Test`.
4. Validate that the source manifest version matches the release tag.
5. Build the module with `Invoke-Build Build`.
6. Publish to PowerShell Gallery, or run a dry-run publish task.
7. Extract release notes from `CHANGELOG.md`.
8. Create or update the GitHub release for the tag.

## Manual Dry-Run Release

Use the `Release On Tag` workflow with `workflow_dispatch` to test the release flow without publishing.

Inputs:

- `release_tag`
- `publish`

Recommended dry-run values:

- `release_tag = X.Y.Z`
- `publish = false`

This path still runs tests, tag/version validation, build, and changelog extraction, but it calls:

```powershell
Invoke-Build PublishBuiltWhatIf
```

That validates the publish path without uploading to PSGallery or creating a GitHub release.

## Real Release

Normal release flow:

1. Update `Source/psDateFunctions.psd1`.
2. Update `CHANGELOG.md`.
3. Run `Invoke-Build Test`.
4. Commit and push the changes.
5. Create and push the release tag:

```powershell
git tag X.Y.Z
git push origin X.Y.Z
```

The GitHub Actions release workflow then:

- reruns tests
- validates the tag/version match
- builds the module
- publishes to PowerShell Gallery
- creates or updates the GitHub release

## Secrets

The release workflow requires this repository secret:

- `PSGALLERY_API_KEY`

The workflow uses the default GitHub token to create or update the GitHub release.

## Notes

- `CHANGELOG.md` is the source for release notes used in GitHub releases.
- `Source/psDateFunctions.psd1` is the source of truth for the current module version.
- The publish tasks use `-SkipAutomaticTags` to avoid the long NuGet tag list generated from exported commands.
