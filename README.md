# setup-rv

A GitHub Action for installing [rv](https://rv.dev), the fast Ruby version manager.

## Usage

### Install rv + Ruby + gems

Install `rv`, the specified Ruby version, and project gems, all in a single step.

```yaml
- name: Install rv, Ruby, and gems
  uses: spinel-coop/setup-rv@v1
  with:
    ruby-version: '3.4'
    install-gems: true
```

### Use the Ruby from `.ruby-version`

```yaml
- name: Set up rv
  uses: spinel-coop/setup-rv@v1
  with:
    ruby-version: 'current'
```

### Specify a working directory

```yaml
- name: Set up rv
  uses: spinel-coop/setup-rv@v1
  with:
    working-directory: 'path/to/working-dir'
```

### Install only rv

```yaml
- name: Install rv
  uses: spinel-coop/setup-rv@v1
```

With `rv` installed, you can use it in your own steps. Here's an example of how you might do that.

```yaml
- name: Install rv
  uses: spinel-coop/setup-rv@v1

- name: Install Ruby
  run: rv ruby install

- name: Install gems
  run: rv ci

- name: Run tests
  run: bin/rails test
```

## Inputs

| Input | Description | Default |
|-------|-------------|---------|
| `ruby-version` | Ruby version to install (e.g. `3.4.2` or `current` to read `.ruby-version`). Omit to skip. | _(none)_ |
| `install-gems` | Run `rv clean-install` and cache installed gems | `false` |
| `working-directory` | Directory containing `Gemfile` and/or `.ruby-version` | `.` |
| `enable-cache` | Cache rv's download cache (`~/.cache/rv`) | `auto` |
| `cache-version` | Increment to invalidate the gem cache | `0` |

## Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `rv-version` | The installed rv version | `0.4.3` |
| `ruby-version` | The installed Ruby version (empty if Ruby not installed) | `4.0.1` |
| `cache-hit` | Whether the gem cache was restored exactly | `true` |

## How it works

By default, `setup-rv` does one thing: installs `rv` and adds it to `PATH`.

Optional features are enabled via inputs:

1. **`ruby-version`** — Install a Ruby version (or `current` to read `.ruby-version`)
2. **`install-gems`** — Run `rv clean-install` and cache `vendor/bundle`
3. **`enable-cache`** — Cache rv's download cache at `~/.cache/rv` (on by default)

## Migrating from `ruby/setup-ruby`

```yaml
# Before (ruby/setup-ruby)
- name: Set up Ruby
  uses: ruby/setup-ruby@v1
  with:
    ruby-version: '3.3'
    bundler-cache: true   # ruby/setup-ruby calls it bundler-cache

# After (setup-rv)
- name: Set up rv
  uses: spinel-coop/setup-rv@v1
  with:
    ruby-version: '3.3'
    install-gems: true   # setup-rv uses rv clean-install
```

## Supported platforms

- Linux (x86_64, ARM64)
- macOS (x86_64, ARM64)
- Windows (x86_64)

## License

MIT
