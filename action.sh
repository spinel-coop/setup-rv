#!/bin/bash
set -euo pipefail

# Install rv
echo "Installing rv..."
curl --proto '=https' --tlsv1.2 -LsSf \
  https://github.com/spinel-coop/rv/releases/latest/download/rv-installer.sh | sh

export PATH="$HOME/.cargo/bin:$PATH"
echo "$HOME/.cargo/bin" >> "$GITHUB_PATH"

# Install Ruby
cd "$WORKING_DIRECTORY"

if [ "$RUBY_VERSION" = "latest" ]; then
  echo "Installing latest Ruby..."
  rv ruby install
else
  echo "Installing Ruby $RUBY_VERSION..."
  rv ruby install "$RUBY_VERSION"
fi

# INSTALLED=$(rv ruby pin) # TODO: make pin print the pinned ruby version
INSTALLED=$(rv ruby list | grep "*" | cut -c 8-12)
echo "Installed Ruby $INSTALLED"

RUBY_BIN="$HOME/.rubies/ruby-$INSTALLED/bin"
export PATH="$RUBY_BIN:$PATH"
echo "$RUBY_BIN" >> "$GITHUB_PATH"
echo "version=$INSTALLED" >> "$GITHUB_OUTPUT"

# Run rv ci
if [ "$BUNDLER_CACHE" = "true" ]; then
  echo "Running rv ci..."
  BUNDLE_PATH=vendor/bundle rv ci
fi
