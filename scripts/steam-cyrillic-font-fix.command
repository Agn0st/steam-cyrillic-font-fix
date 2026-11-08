#!/bin/bash
# Steam Cyrillic Font Fix
# Fixes Cyrillic text showing up in Times on Steam for macOS.
#
#   Double-click this file, or run:  ./steam-cyrillic-font-fix.command [options]
#
#   With no options it installs the font and fixes the Steam client.
#   Pick parts to apply only those (they can be combined):
#   --font-only       install the Motiva Sans fallback font
#   --client-only     set Arial as the Cyrillic sans-serif font in the Steam client
#   --chrome          set Arial as the sans-serif font in Google Chrome (all profiles)
#   --chrome-beta     the same for Google Chrome Beta
#   --chrome-canary   the same for Google Chrome Canary
#
#   --undo            remove what the chosen parts changed
#   --yes             don't ask before closing Steam or Chrome
#   --help            show this help

set -u

FONT_NAME="MotivaSansfallback-Regular.ttf"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FONTS_DIR="${SCFF_FONTS_DIR:-$HOME/Library/Fonts}"
STEAM_PREFS="${SCFF_PREFS:-$HOME/Library/Application Support/Steam/config/htmlcache/Default/Preferences}"
CHROME_ROOT="${SCFF_CHROME_ROOT:-$HOME/Library/Application Support/Google}"

do_font=0
do_client=0
do_chrome=0
do_chrome_beta=0
do_chrome_canary=0
undo=0
assume_yes=0

for arg in "$@"; do
  case "$arg" in
    --font-only)     do_font=1 ;;
    --client-only)   do_client=1 ;;
    --chrome)        do_chrome=1 ;;
    --chrome-beta)   do_chrome_beta=1 ;;
    --chrome-canary) do_chrome_canary=1 ;;
    --undo)          undo=1 ;;
    --yes|-y)        assume_yes=1 ;;
    --help|-h)       sed -n '2,18p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $arg (see --help)"; exit 2 ;;
  esac
done

# No parts chosen: the default fix.
if [ $((do_font + do_client + do_chrome + do_chrome_beta + do_chrome_canary)) = 0 ]; then
  do_font=1
  do_client=1
fi

if [ "$(uname)" != "Darwin" ]; then
  echo "This fix is for macOS only."; exit 1
fi

ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
skip() { printf '  \033[2m–\033[0m %s\n' "$1"; }
fail() { printf '  \033[31m✗\033[0m %s\n' "$1"; }

# ---------- Font ----------

find_font() {
  for f in "${FONT_FILE:-}" "$SCRIPT_DIR/$FONT_NAME" "$SCRIPT_DIR/../Font/$FONT_NAME"; do
    [ -n "$f" ] && [ -f "$f" ] && { echo "$f"; return 0; }
  done
  return 1
}

font_install() {
  local src dst="$FONTS_DIR/$FONT_NAME"
  if ! src="$(find_font)"; then
    fail "Font file $FONT_NAME not found next to this script."; return 1
  fi
  if [ -f "$dst" ] && cmp -s "$src" "$dst"; then
    skip "Font is already installed."; return 0
  fi
  mkdir -p "$FONTS_DIR" && cp "$src" "$dst" || { fail "Couldn't copy the font to $FONTS_DIR."; return 1; }
  ok "Installed Motiva Sans fallback to $FONTS_DIR."
  font_changed=1
}

font_uninstall() {
  local dst="$FONTS_DIR/$FONT_NAME"
  if [ ! -f "$dst" ]; then skip "Font isn't installed."; return 0; fi
  rm -f "$dst" || { fail "Couldn't remove $dst."; return 1; }
  ok "Removed Motiva Sans fallback."
  font_changed=1
}

# ---------- Chromium preferences (Steam client and Chrome) ----------

# Reads or edits the webkit font prefs in a Chromium Preferences JSON file.
#   prefs_js <file> check  -> prints "set" or "unset"
#   prefs_js <file> set    -> sets Cyrl/Zyyy sans-serif to Arial
#   prefs_js <file> unset  -> removes those keys again
prefs_js() {
  osascript -l JavaScript - "$1" "$2" <<'JS'
ObjC.import('Foundation');
function run(argv) {
  const path = argv[0], mode = argv[1];
  const raw = $.NSString.stringWithContentsOfFileEncodingError(path, $.NSUTF8StringEncoding, null);
  if (raw.isNil()) throw new Error('Cannot read ' + path);
  const d = JSON.parse(raw.js);
  const ss = (((d.webkit || {}).webprefs || {}).fonts || {}).sansserif || {};
  const isSet = ss.Cyrl === 'Arial' && ss.Zyyy === 'Arial';
  if (mode === 'check') return isSet ? 'set' : 'unset';
  if (mode === 'set') {
    d.webkit = d.webkit || {};
    d.webkit.webprefs = d.webkit.webprefs || {};
    d.webkit.webprefs.fonts = d.webkit.webprefs.fonts || {};
    d.webkit.webprefs.fonts.sansserif = Object.assign(d.webkit.webprefs.fonts.sansserif || {}, { Cyrl: 'Arial', Zyyy: 'Arial' });
  } else if (mode === 'unset') {
    if (d.webkit && d.webkit.webprefs && d.webkit.webprefs.fonts && d.webkit.webprefs.fonts.sansserif) {
      const s = d.webkit.webprefs.fonts.sansserif;
      if (s.Cyrl === 'Arial') delete s.Cyrl;
      if (s.Zyyy === 'Arial') delete s.Zyyy;
      // Drop the objects this fix created if they are now empty.
      const f = d.webkit.webprefs.fonts, w = d.webkit.webprefs;
      if (!Object.keys(s).length) delete f.sansserif;
      if (!Object.keys(f).length) delete w.fonts;
      if (!Object.keys(w).length) delete d.webkit.webprefs;
      if (!Object.keys(d.webkit).length) delete d.webkit;
    }
  } else throw new Error('Unknown mode ' + mode);
  const ok = $(JSON.stringify(d)).writeToFileAtomicallyEncodingError(path, false, $.NSUTF8StringEncoding, null);
  if (!ok) throw new Error('Cannot write ' + path);
  return 'done';
}
JS
}

# app_running <process regex>
app_running() { [ -z "${SCFF_SKIP_APPS:-}" ] && pgrep -f "$1" >/dev/null 2>&1; }

# app_quit <label> <app name> <process regex> <note>
app_quit() {
  if [ "$assume_yes" = 0 ] && [ -t 0 ]; then
    [ -n "$4" ] && printf '  %s\n' "$4"
    printf '  %s has to be closed to change its settings. Close %s now? [Y/n] ' "$1" "$1"
    read -r answer
    case "$answer" in [nN]*) fail "Skipped $1. Quit it and run this again."; return 1 ;; esac
  fi
  osascript -e "tell application \"$2\" to quit" >/dev/null 2>&1
  for _ in $(seq 1 60); do
    app_running "$3" || { ok "Closed $1."; return 0; }
    sleep 1
  done
  fail "$1 is still running. Quit it with Cmd+Q and run this again."
  return 1
}

# app_apply <set|unset> <label> <app name> <process regex> <note> <missing message> <prefs file>...
# Closes the app if needed, edits every prefs file, then reopens the app.
app_apply() {
  local want="$1" label="$2" app="$3" proc="$4" note="$5" missing="$6"; shift 6
  local f todo=() state was_running=0 errors=0

  if [ "$#" = 0 ]; then
    if [ "$want" = set ]; then fail "$missing"; return 1; fi
    skip "$label settings aren't changed."; return 0
  fi
  for f in "$@"; do
    state="$(prefs_js "$f" check 2>/dev/null)" || { fail "Couldn't read $f"; errors=1; continue; }
    [ "$state" = "$want" ] || todo+=("$f")
  done
  if [ "${#todo[@]}" = 0 ]; then
    [ "$errors" = 1 ] && return 1
    [ "$want" = set ] && skip "$label already uses Arial for Cyrillic." \
                      || skip "$label settings aren't changed."
    return 0
  fi

  if app_running "$proc"; then
    was_running=1
    app_quit "$label" "$app" "$proc" "$note" || return 1
  fi

  for f in "${todo[@]}"; do
    [ -f "$f.bak-fontfix" ] || cp -p "$f" "$f.bak-fontfix"
    if ! prefs_js "$f" "$want" >/dev/null 2>&1; then
      fail "Couldn't edit $f. Backup: $f.bak-fontfix"; errors=1
    fi
  done
  if [ "$errors" = 0 ]; then
    local where=""
    [ "$#" -gt 1 ] && where=" (${#todo[@]} profiles)"
    [ "$want" = set ] && ok "$label now uses Arial for Cyrillic$where. Backup: Preferences.bak-fontfix" \
                      || ok "Removed the $label font setting$where."
  fi

  if [ "$was_running" = 1 ]; then
    open -a "$app" && ok "Opened $label again." && restarted+="|$app|"
  fi
  return "$errors"
}

client_apply() {
  local files=()
  [ -f "$STEAM_PREFS" ] && files+=("$STEAM_PREFS")
  app_apply "$1" "Steam client" "Steam" "[/]steam_osx( |$)" "" \
    "Steam settings not found. Open Steam once, then run this again." ${files[@]+"${files[@]}"}
}

# chrome_apply <set|unset> <label> <app name> <data folder name>
chrome_apply() {
  local want="$1" label="$2" app="$3" dir="$CHROME_ROOT/$4" files=() p
  if [ ! -d "$dir" ]; then
    if [ "$want" = set ]; then fail "$label isn't installed or was never opened."; return 1; fi
    skip "$label settings aren't changed."; return 0
  fi
  for p in "$dir"/Default "$dir"/Profile\ *; do
    [ -f "$p/Preferences" ] && files+=("$p/Preferences")
  done
  app_apply "$want" "$label" "$app" "/$app\.app/Contents/MacOS/$app( |$)" \
    "Open tabs come back only if \"Continue where you left off\" is on in $label settings." \
    "No $label profiles found. Open $label once, then run this again." ${files[@]+"${files[@]}"}
}

# ---------- Run ----------

echo
echo "Steam Cyrillic Font Fix"
[ "$undo" = 1 ] && echo "Removing the fix…" || echo "Applying the fix…"
echo

mode=set
[ "$undo" = 1 ] && mode=unset
status=0
font_changed=0
restarted=""

if [ "$do_font" = 1 ]; then
  if [ "$undo" = 1 ]; then font_uninstall || status=1; else font_install || status=1; fi
fi
[ "$do_client" = 1 ]        && { client_apply "$mode" || status=1; }
[ "$do_chrome" = 1 ]        && { chrome_apply "$mode" "Chrome" "Google Chrome" "Chrome" || status=1; }
[ "$do_chrome_beta" = 1 ]   && { chrome_apply "$mode" "Chrome Beta" "Google Chrome Beta" "Chrome Beta" || status=1; }
[ "$do_chrome_canary" = 1 ] && { chrome_apply "$mode" "Chrome Canary" "Google Chrome Canary" "Chrome Canary" || status=1; }

echo
if [ "$font_changed" = 1 ]; then
  # Apps load fonts at launch. Tell the user which open ones still need a restart.
  need=()
  case "$restarted" in *"|Steam|"*) ;; *) app_running "[/]steam_osx( |$)" && need+=("Steam") ;; esac
  for a in "Google Chrome" "Google Chrome Beta" "Google Chrome Canary"; do
    case "$restarted" in *"|$a|"*) ;; *) app_running "/$a\.app/Contents/MacOS/$a( |$)" && need+=("$a") ;; esac
  done
  if [ "${#need[@]}" -gt 0 ]; then
    list="$(printf '%s, ' "${need[@]}")"
    echo "Quit ${list%, } completely with Cmd+Q and open again to see the change."
  fi
fi
[ "$status" = 0 ] && echo "Done." || echo "Finished with errors, see above."
exit "$status"
