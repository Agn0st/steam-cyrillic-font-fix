<h1 align="center">Steam Cyrillic Font Fix</h1>

<p align="center">
  <b>English</b> · <a href="README.uk.md">Українська</a> · <a href="README.es.md">Español</a>
</p>

<p align="center">
  <strong>Cyrillic text on Steam looks like the rest of the page again.</strong><br>
  One font file for macOS fixes Cyrillic text that shows up in Times in the Steam client and in Google Chrome.
</p>

<p align="center">
  <img alt="Steam client and web" src="https://shieldcn.dev/badge/Steam-Client%20%26%20Web-1B2838.svg?logo=steam&amp;size=xs">
  <img alt="Google Chrome" src="https://shieldcn.dev/badge/Google%20Chrome-4285F4.svg?logo=googlechrome&amp;size=xs">
  <img alt="macOS" src="https://shieldcn.dev/badge/macOS-000000.svg?logo=apple&amp;size=xs">
  <img alt="Fixes Cyrillic text" src="https://shieldcn.dev/badge/Fix-Cyrillic%20text-16A34A.svg?logo=ri:RiTranslate2&amp;size=xs">
  <a href="#license"><img alt="Font under Apache 2.0, project under MIT" src="https://shieldcn.dev/badge/License-Apache%202.0%20%2B%20MIT-6B7280.svg?logo=ri:RiScales3Line&amp;size=xs"></a>
</p>

<p align="center">
  <a href="https://github.com/Agn0st/steam-cyrilic-font-fix/raw/main/Font/MotivaSansfallback-Regular.ttf"><img alt="Download the font" src="https://shieldcn.dev/badge/Download-Font-7C3AED.svg?logo=ri:RiDownload2Line&amp;size=default"></a>
</p>

<p align="center">
  <a href="#the-problem">The problem</a> · <a href="#solution">Solution</a> · <a href="#installation">Installation</a> · <a href="#uninstall">Uninstall</a>
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

## Solution

This repository contains a modified version of the **Motiva Sans fallback** font with
Cyrillic characters added. Once the font is installed, Steam and Chrome take Cyrillic
characters from it and the text renders correctly.

> [!NOTE]
> Nothing else is replaced. System fonts and the fonts other apps use stay as they are.
> Other apps don't request this font, so they look the same.

## Installation

1. Download [`MotivaSansfallback-Regular.ttf`](https://github.com/Agn0st/steam-cyrilic-font-fix/raw/main/Font/MotivaSansfallback-Regular.ttf).
2. Double-click the file and click **Install Font** in Font Book.
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

1. Open **Font Book** and find **Motiva Sans fallback**.
2. Right-click it and choose **Remove**.
3. Restart Steam and Chrome.

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

## License

This repository uses two licenses:

- **The font** in `Font/` is licensed under the [Apache License 2.0](Font/LICENSE) by its original authors. It isn't my work.
- **Everything else**, including this README, is under the [MIT License](LICENSE).

Steam Cyrillic Font Fix is an unofficial project independent of Valve and Steam.
