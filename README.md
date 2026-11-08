<h1 align="center">Steam Cyrillic Font Fix</h1>

<p align="center">
  <b>English</b> · <a href="README.uk.md">Українська</a> · <a href="README.es.md">Español</a>
</p>

<p align="center">
  <strong>Fix Cyrillic text showing up in Times on Steam for macOS.</strong>
</p>

<p align="center">
  <img alt="Steam client and web" src="https://shieldcn.dev/badge/Steam-Client%20%26%20Web-1B2838.svg?logo=steam&amp;size=xs">
  <img alt="Google Chrome" src="https://shieldcn.dev/badge/Google%20Chrome-4285F4.svg?logo=googlechrome&amp;size=xs">
  <img alt="macOS" src="https://shieldcn.dev/badge/macOS-000000.svg?logo=apple&amp;size=xs">
  <img alt="Fixes Cyrillic text" src="https://shieldcn.dev/badge/Fix-Cyrillic%20text-16A34A.svg?logo=ri:RiTranslate2&amp;size=xs">
  <a href="#license"><img alt="Font under Apache 2.0, project under MIT" src="https://shieldcn.dev/badge/License-Apache%202.0%20%2B%20MIT-6B7280.svg?logo=ri:RiScales3Line&amp;size=xs"></a>
  <a href="https://www.npmjs.com/package/steam-cyrillic-font-fix"><img alt="npm version" src="https://shieldcn.dev/npm/steam-cyrillic-font-fix.svg?logo=npm&amp;color=CB3837&amp;size=xs"></a>
</p>

<p align="center">
  <a href="https://github.com/Agn0st/steam-cyrillic-font-fix/releases/latest"><img alt="Download the latest release" src="https://shieldcn.dev/badge/Download-Latest%20release-7C3AED.svg?logo=ri:RiDownload2Line&amp;size=default"></a>
</p>

<p align="center">
  <a href="#the-problem">The problem</a> · <a href="#solution">Solution</a> · <a href="#installation">Installation</a> · <a href="#uninstall">Uninstall</a> · <a href="#alternative-solutions">Alternative solutions</a>
</p>

## The problem

On macOS, some Steam pages render Cyrillic text in **Times**, a serif font, while
Latin text on the same page looks normal. It happens in the **Steam client** and
on the Steam website in **Google Chrome**.

The page asks for a font called **Motiva Sans fallback**. macOS doesn't have it,
so for Cyrillic characters the browser ends up on the system default serif font.

| Before | After |
|--------|-------|
| ![Cyrillic text on a Steam page rendered in Times](Images/before.png) | ![The same text rendered correctly after installing the font](Images/after.png) |

<br>

## Solution

This repository contains a modified version of the **Motiva Sans fallback** font with
Cyrillic characters added. Once the font is installed, Steam and Chrome take Cyrillic
characters from it and the text renders correctly.

> [!NOTE]
> Nothing else is replaced. System fonts and the fonts other apps use stay as they are.
> Other apps don't request this font, so they look the same.

## Installation

### Automatic

The installer adds the font and sets Arial for Cyrillic text in the Steam client
(see [Alternative solutions](#2-only-for-the-steam-client)). If Steam is open, it closes
and reopens it.

**Without Terminal**

1. Download `steam-cyrillic-font-fix-v1.2.zip` from [Releases](https://github.com/Agn0st/steam-cyrillic-font-fix/releases/latest) and unzip it.
2. Double-click **Install Steam Cyrillic Font Fix.command**.
3. Quit **Chrome** completely with <kbd>⌘</kbd> <kbd>Q</kbd>, then open it again.

> [!NOTE]
> If macOS says the file can't be opened, right-click it, choose **Open**, then click **Open**.

**With Node.js**

```bash
npx steam-cyrillic-font-fix
```

Add `--font-only` or `--client-only` to apply one part only, or `--chrome` to fix Chrome too
(see [Only for Chrome](#1-only-for-chrome)).

> [!NOTE]
> No Node.js? Install it from [nodejs.org](https://nodejs.org) or with [Homebrew](https://brew.sh): `brew install node`.
> `npx` comes with it.

### Manual

1. Download [`MotivaSansfallback-Regular.ttf`](https://github.com/Agn0st/steam-cyrillic-font-fix/releases/latest).
2. Double-click `MotivaSansfallback-Regular.ttf` and click **Install Font** in Font Book.
   You can also copy it to `~/Library/Fonts`.
3. Quit **Steam** and **Chrome** completely with <kbd>⌘</kbd> <kbd>Q</kbd>, then open them again.

> [!NOTE]
> Closing the window isn't enough. Both apps load fonts at launch, so they need a full restart.

### If Cyrillic text still shows up in Times

- Open Font Book and check that **Motiva Sans fallback** is installed and enabled,
  with no duplicate copy marked by a warning sign.
- Clear the macOS font cache and restart your Mac:

  ```bash
  sudo atsutil databases -remove
  ```

## Uninstall

Remove the fix the same way you installed it.

### 1. Installed with Node.js

```bash
npx steam-cyrillic-font-fix --undo
```

If you also fixed Chrome, undo it separately, for example with `npx steam-cyrillic-font-fix --undo --chrome`.

### 2. Installed with the .command file

Drag **Install Steam Cyrillic Font Fix.command** into Terminal, add `--undo` and press <kbd>Return</kbd>.

### 3. Installed by hand

1. Open **Font Book** and find **Motiva Sans fallback**.
2. Right-click it and choose **Remove**.
3. Restart Steam and Chrome.

<br>

## Alternative solutions

Some Steam elements ask for `"Motiva Sans", sans-serif` and skip **Motiva Sans fallback**,
so the font above can't reach them. One example is the thin **Currently Online** header
on a profile page. These options fix them without installing the font.

### 1. Only for Chrome

No code needed. Open `chrome://settings/fonts` and set **Sans-serif font** to **Arial**.

Or let the installer do it for every Chrome profile:

```bash
npx steam-cyrillic-font-fix --chrome
```

Use `--chrome-beta` or `--chrome-canary` for those versions. Chrome closes and reopens. Open tabs
come back only if **Continue where you left off** is on in Chrome settings.

> [!WARNING]
> This changes `sans-serif` on every website, not only for Cyrillic text on Steam.

### 2. Only for the Steam client

The Steam client is built on Chromium and keeps its browser settings in a file you can
edit. The [installer](#automatic) sets Arial as its sans-serif font for you. To change only
the Steam client:

```bash
npx steam-cyrillic-font-fix --client-only
```

To do it by hand:

1. Quit **Steam** completely with <kbd>⌘</kbd> <kbd>Q</kbd>. Steam rewrites the file on exit.
2. Back up `~/Library/Application Support/Steam/config/htmlcache/Default/Preferences`.
3. Add this to the top level of the JSON in that file:

   ```json
   "webkit": {
     "webprefs": {
       "fonts": {
         "sansserif": {
           "Cyrl": "Arial",
           "Zyyy": "Arial"
         }
       }
     }
   }
   ```

4. Open Steam again.

To undo it, quit Steam and restore the backup.

<br>

## Tested

| App | Version | macOS |
|-----|---------|-------|
| Steam client | November 2026 | 27.0.1 |
| Google Chrome | 157.0.8103.38 | 27.0.1 |
| Google Chrome Beta | 158.0.8127.18 | 27.0.1 |
| Google Chrome Canary | 159.0.8149.0 | 27.0.1 |

> [!NOTE]
> The fix isn't tied to these versions. It is a regular system font, so it should work
> with other versions of Steam, Chrome and macOS.

<br>

## License

This repository uses two licenses:

- **The font** in `Font/` is licensed under the [Apache License 2.0](LICENSE-APACHE) by its original authors. It isn't my work.
- **Everything else**, including this README, is under the [MIT License](LICENSE-MIT).

Steam Cyrillic Font Fix is an unofficial project independent of Valve and Steam.
