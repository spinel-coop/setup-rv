# setup-rv

A GitHub Action for fast Ruby version management using [rv](https://github.com/spinel-coop/rv).

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
| `cache-version` | Increment to invalidate the gem cache | `0` |

## Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `ruby-version` | The installed Ruby version | `4.0.1` |
| `cache-hit` | Whether the gem cache was restored exactly | `true` |

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

1. Installs `rv` and the specified Ruby version (or restores from cache)
2. If `bundler-cache: true`:
   - Restores gem cache (includes compiled native extensions)
   - Runs `rv ci` to install gems
   - Saves gem cache (keyed by OS, arch, Ruby version, and `Gemfile.lock`)

## Supported platforms

- Linux (x86_64, ARM64)
- macOS (x86_64, ARM64)
- Windows (x86_64) - coming soon

## License

MIT
