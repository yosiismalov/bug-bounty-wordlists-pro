#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_DIR="${HOME}/.local/share/bbwp"
BIN_DIR="${HOME}/.local/bin"

echo "[*] Installing Bug Bounty Wordlists Pro..."

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

rm -rf "$INSTALL_DIR"/*

cp -r \
    "$ROOT_DIR/cli" \
    "$ROOT_DIR/wordlists" \
    "$ROOT_DIR/VERSION.txt" \
    "$INSTALL_DIR/"

cat > "$BIN_DIR/bbwp" <<EOF_WRAPPER
#!/usr/bin/env bash
exec python3 "$INSTALL_DIR/cli/bbwp" "\$@"
EOF_WRAPPER

chmod +x "$BIN_DIR/bbwp"

echo "[+] Installed successfully."
echo "[+] Command: $BIN_DIR/bbwp"

case ":$PATH:" in
    *":$BIN_DIR:"*)
        ;;
    *)
        echo
        echo "Add this line to your shell configuration:"
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
        ;;
esac
