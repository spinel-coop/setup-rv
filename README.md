# setup-rv

A GitHub Action for fast Ruby version management using [rv](https://github.com/spinel-coop/rv).

_**Note:** This Action is not yet production-ready._

## Usage

### Install the latest Ruby

```yaml
- name: Setup rv
  uses: spinel-coop/setup-rv@v1

- name: Verify Ruby
  run: ruby --version
```

### Install a specific Ruby version

```yaml
- name: Setup rv
  uses: spinel-coop/setup-rv@v1
  with:
    ruby-version: '3.3.0'
```

### Use bundler caching

```yaml
- name: Setup rv
  uses: spinel-coop/setup-rv@v1
  with:
    ruby-version: '3.3'
    bundler-cache: true
```

### Specify a working directory

```yaml
- name: Setup rv
  uses: spinel-coop/setup-rv@v1
  with:
    bundler-cache: true
    working-directory: 'path/to/working-dir'
```

## Inputs

| Input | Description | Default |
|-------|-------------|---------|
| `ruby-version` | Ruby version to install | `latest` |
| `bundler-cache` | Run `rv ci` and cache installed gems | `false` |
| `working-directory` | Directory containing `Gemfile` and/or `.ruby-version` | `.` |

## Outputs

| Output | Description |
|--------|-------------|
| `ruby-version` | The installed Ruby version |

## Migrating from `ruby/setup-ruby`

`setup-rv` is designed as a drop-in replacement for basic `ruby/setup-ruby` usage:

```yaml
# Before
- name: Setup Ruby
  uses: ruby/setup-ruby@v1
  with:
    ruby-version: '3.3'
    bundler-cache: true

# After
- name: Setup rv
  uses: spinel-coop/setup-rv@v1
  with:
    ruby-version: '3.3'
    bundler-cache: true
```

## How it works

1. Downloads and installs the latest `rv` binary
2. Installs the specified Ruby version (or latest) using `rv ruby install`
3. If `bundler-cache: true`:
   - Restores rv's cache from the GitHub Actions cache
   - Runs `rv ci` to install gems and build native extensions
   - Saves rv's cache for future runs

## Supported platforms

- Linux (x86_64, ARM64)
- macOS (x86_64, ARM64)

## License

MIT
