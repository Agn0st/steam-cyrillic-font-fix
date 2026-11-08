#!/bin/bash
# Builds the GitHub release zip: dist/steam-cyrillic-font-fix-v<version>.zip
# The version comes from package.json.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
# Release name drops a trailing ".0" patch: 1.1.0 -> 1.1
VERSION="$(node -p "require('./package.json').version.replace(/\\.0$/, '')")"
NAME="steam-cyrillic-font-fix-v$VERSION"
OUT="dist/$NAME"

rm -rf "$OUT" "$OUT.zip"
mkdir -p "$OUT"
cp Font/MotivaSansfallback-Regular.ttf LICENSE-APACHE LICENSE-MIT "$OUT/"
cp scripts/steam-cyrillic-font-fix.command "$OUT/Install Steam Cyrillic Font Fix.command"
chmod +x "$OUT/Install Steam Cyrillic Font Fix.command"

cat > "$OUT/INSTALL.txt" <<'EOF'
Steam Cyrillic Font Fix
Fix Cyrillic text showing up in Times on Steam for macOS.

Install
1. Double-click "Install Steam Cyrillic Font Fix.command". It installs the font,
   sets Arial as the Cyrillic font in the Steam client, and restarts Steam if it is open.
2. Quit Chrome completely with Cmd+Q, then open it again.

If macOS says the file can't be opened, right-click it, choose Open, then click Open.

Install by hand
1. Double-click MotivaSansfallback-Regular.ttf and click Install Font in Font Book.
2. Quit Steam and Chrome completely with Cmd+Q, then open them again.

Fix Chrome too (optional)
1. Open Terminal and drag "Install Steam Cyrillic Font Fix.command" into its window.
2. Type a space and --chrome, then press Return.
   Use --chrome-beta or --chrome-canary for those versions.
This sets Arial as the sans-serif font on every website in Chrome. Chrome closes and reopens;
open tabs come back only if "Continue where you left off" is on in Chrome settings.

Uninstall
1. Open Terminal and drag "Install Steam Cyrillic Font Fix.command" into its window.
2. Type a space and --undo, then press Return.
Or open Font Book, find Motiva Sans fallback, right-click it and choose Remove.

Licenses
The font is licensed under the Apache License 2.0 by its original authors (LICENSE-APACHE).
Everything else is under the MIT License (LICENSE-MIT).

More: https://github.com/Agn0st/steam-cyrillic-font-fix
EOF

(cd dist && ditto -c -k --norsrc --noextattr --noqtn --keepParent "$NAME" "$NAME.zip")
echo "Built $OUT.zip"
