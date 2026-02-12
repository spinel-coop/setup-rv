#!/bin/bash
set -euo pipefail

ACTION="${1:-all}"

install_rv() {
  echo "Installing rv..."
  curl --proto '=https' --tlsv1.2 -LsSf --fail \
    https://github.com/spinel-coop/rv/releases/latest/download/rv-installer.sh | sh

  export PATH="$HOME/.cargo/bin:$PATH"
  echo "$HOME/.cargo/bin" >> "$GITHUB_PATH"
  echo "rv-version=$(rv --version | awk '{print $2}')" >> "$GITHUB_OUTPUT"
}

install_ruby() {
  if [ "$RUBY_VERSION" = "latest" ]; then
    echo "Installing latest Ruby..."
    rv ruby install
  else
    echo "Installing Ruby $RUBY_VERSION..."
    rv ruby install "$RUBY_VERSION"
  fi

  INSTALLED=$(rv ruby list --format json | jq -r '.[] | select(.active == true) | .version | sub("^ruby-"; "")')
  echo "Installed Ruby $INSTALLED"

  RUBY_BIN="$HOME/.local/share/rv/rubies/ruby-$INSTALLED/bin"
  export PATH="$RUBY_BIN:$PATH"
  echo "$RUBY_BIN" >> "$GITHUB_PATH"
  echo "ruby-version=$INSTALLED" >> "$GITHUB_OUTPUT"
}

install_gems() {
  echo "Running rv ci..."
  BUNDLE_PATH=vendor/bundle rv ci
  echo "BUNDLE_PATH=vendor/bundle" >> "$GITHUB_ENV"
}

case "$ACTION" in
  install-rv)
    install_rv
    ;;
  install-ruby)
    install_ruby
    ;;
  install-gems)
    install_gems
    ;;
  *)
    echo "Unknown action: $ACTION"
    echo "Usage: action.sh [install-rv|install-ruby|install-gems]"
    exit 1
    ;;
esac
